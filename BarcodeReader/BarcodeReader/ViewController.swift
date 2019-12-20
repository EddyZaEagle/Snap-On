//
//  ViewController.swift
//  BarcodeReader
//
//  Created by Adam Moreno on 12/15/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit
import Vision
import VisionKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var videoOutputView: UIImageView!
    
    let textBoxSize: CGSize = CGSize(width: 200.0, height: 200.0)
    let contentFormatting: [NSAttributedString.Key : Any] = [
        .foregroundColor : UIColor.black,
        .font : UIFont.systemFont(ofSize: 18.0, weight: .medium)
    ]
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var requests = [VNRequest]()
    var totalNumberOfTextBoxes: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpCamera()
        startBarcodeDetection()
    }
    
    override func viewDidLoad() {
        
    }
    
    private func startBarcodeDetection() {
        let barcodeRequest = VNDetectBarcodesRequest(completionHandler: self.detectBarcodeHandler)
        self.requests = [barcodeRequest]
    }
    
    private // Handle barcode detection requests
    func detectBarcodeHandler(request: VNRequest, error: Error?) {
        if error != nil {
            print(error!)
        }
        guard let barcodes = request.results else {
            return
        }

        // Perform UI updates on the main thread
        DispatchQueue.main.async {
            if self.captureSession.isRunning {
                self.videoOutputView.layer.sublayers?.removeSubrange(1...)
                self.totalNumberOfTextBoxes = 0
                
                // This will be used to eliminate duplicate findings
                var barcodeObservations: [String : VNBarcodeObservation] = [:]
                for barcode in barcodes {
                    if let potentialQRCode = barcode as? VNBarcodeObservation {
                        if potentialQRCode.symbology == .QR {
                            barcodeObservations[potentialQRCode.payloadStringValue!] = potentialQRCode
                        }
                    }
                }

                for (_, barcodeObservation) in barcodeObservations {
                    self.highlightQRCode(barcode: barcodeObservation)
                }
                for (barcodeContent, barcodeObservation) in barcodeObservations {
                    self.drawTextBox(barcodeObservation: barcodeObservation, content: barcodeContent)
                }
            }
        }
    }
    
    private func highlightQRCode(barcode: VNBarcodeObservation) {
        let barcodeBounds = self.adjustBoundsToScreen(barcode: barcode)

        let outline = CALayer()
        outline.frame = barcodeBounds
        outline.borderWidth = 2.0
        outline.borderColor = UIColor.red.cgColor

        // We are inserting the highlights at the beginning of the sublayer queue
        // To avoid overlapping with the textboxes
        self.videoOutputView.layer.insertSublayer(outline, at: 1)
    }
    
    private func drawTextBox(barcodeObservation: VNBarcodeObservation, content: String) {
        let barcodeBounds = self.adjustBoundsToScreen(barcode: barcodeObservation)
        
        let textLayerFrame: CGRect = CGRect(x: barcodeBounds.origin.x + barcodeBounds.size.width, y: barcodeBounds.origin.y - self.textBoxSize.height,
                                            width: textBoxSize.width, height: textBoxSize.height)
        if self.videoOutputView.bounds.contains(textLayerFrame) {
            // Readjust box locations so that there aren't any overlapping ones...
            guard let readjustedFrame = self.readjustBoxLocationBasedOnExistingLayers(originalBox: textLayerFrame, barcodeSize: barcodeBounds.size) else {
                return
            }
            
            let textBox = self.createTextLayer(content: content, frame: readjustedFrame)
            textBox.name = content
         
            self.videoOutputView.layer.addSublayer(textBox)
            self.totalNumberOfTextBoxes += 1
        }
    }
    
    private func adjustBoundsToScreen(barcode: VNBarcodeObservation) -> CGRect {
        // Current origin is on the bottom-left corner
        let xCord = barcode.boundingBox.origin.x * self.videoOutputView.frame.size.width
        var yCord = (1 - barcode.boundingBox.origin.y) * self.videoOutputView.frame.size.height
        let width = barcode.boundingBox.size.width * self.videoOutputView.frame.size.width
        var height = -1 * barcode.boundingBox.size.height * self.videoOutputView.frame.size.height
        
        // Re-adjust origin to be on the top-left corner, so that calculations can be standardized
        yCord += height
        height *= -1

        return CGRect(x: xCord, y: yCord, width: width, height: height)
    }
    
    private func readjustBoxLocationBasedOnExistingLayers(originalBox: CGRect, barcodeSize: CGSize) -> CGRect? {
        guard let videoOutputLayers: [CALayer] = self.videoOutputView.layer.sublayers else {
            return nil
        }

        // Skip the first layer (i.e. the video layer) and outline layers
        let textBoxLayers: [CALayer] = Array(videoOutputLayers[(videoOutputLayers.count - self.totalNumberOfTextBoxes)...]);
        
        let bottomLeftAnchorBox = originalBox;
        let topLeftAnchorBox = CGRect(x: originalBox.origin.x, y: originalBox.origin.y + originalBox.size.height + barcodeSize.height,
                                      width: originalBox.size.width, height: originalBox.size.height)
        let topRightAnchorBox = CGRect(x: originalBox.origin.x - barcodeSize.width - originalBox.size.width, y: originalBox.origin.y + barcodeSize.height + originalBox.size.height,
                                       width: originalBox.size.width, height: originalBox.size.height)
        let bottomRightAnchorBox = CGRect(x: originalBox.origin.x - barcodeSize.width - originalBox.size.width, y: originalBox.origin.y,
                                          width: originalBox.size.width, height: originalBox.size.height)
        var potentialBoxes: [BoxAnchorLocation : CGRect] = [
            .bottomLeft : bottomLeftAnchorBox,
            .topLeft : topLeftAnchorBox,
            .topRight : topRightAnchorBox,
            .bottomRight : bottomRightAnchorBox
        ]
        
        var potentialBoxToUse: (CGRect?, BoxAnchorLocation) = (nil, .none)
        for layer in textBoxLayers {
            for (type, potentialBox) in potentialBoxes {
                if self.videoOutputView.bounds.contains(potentialBox) && !potentialBox.intersects(layer.frame) {
                    potentialBoxToUse = (potentialBox, type)
                } else {
                    if potentialBoxToUse.1 == type {
                        potentialBoxToUse = (nil, .none)
                    }
                    potentialBoxes.removeValue(forKey: type)
                }
            }
        }
        
        if textBoxLayers.count < 1 {
            potentialBoxToUse = (originalBox, .bottomLeft)
        }
        
        return potentialBoxToUse.0
    }
    
    private func createTextLayer(content: String, frame: CGRect) -> CATextLayer {
        let textBox = CATextLayer()
        textBox.frame = frame
        textBox.backgroundColor = UIColor.white.cgColor
        textBox.cornerRadius = 6.0
        
        textBox.shadowRadius = 3.0
        textBox.shadowOffset = CGSize(width: 0, height: 0)
        textBox.shadowColor = UIColor.black.cgColor
        textBox.shadowOpacity = 0.9
        
        let textBoxString = NSAttributedString(string: content, attributes: self.contentFormatting)
        textBox.string = textBoxString

        textBox.contentsScale = UIScreen.main.scale
        textBox.isWrapped = true
        
        return textBox
    }
    
    private func setUpCamera() {
        // Enable live stream video
        self.captureSession.sessionPreset = AVCaptureSession.Preset.photo
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
        let deviceOutput = AVCaptureVideoDataOutput()
        deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        // Set the quality of the video
        deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
        // What the camera is seeing
        self.captureSession.addInput(deviceInput)
        // What we will display on the screen
        self.captureSession.addOutput(deviceOutput)

        // Show the video as it's being captured
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.frame = self.videoOutputView.bounds
        self.videoOutputView.layer.addSublayer(videoPreviewLayer!)
        
        self.captureSession.startRunning()
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    private func updatePreviewLayer(layer: AVCaptureConnection, orientation: AVCaptureVideoOrientation) {
      layer.videoOrientation = orientation
      videoPreviewLayer?.frame = self.view.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.videoOutputView.layer.sublayers?[0].frame = videoOutputView.bounds
      
          if let connection =  self.videoPreviewLayer?.connection  {
            let currentDevice: UIDevice = UIDevice.current
            let orientation: UIDeviceOrientation = currentDevice.orientation
            let previewLayerConnection : AVCaptureConnection = connection
            
                if previewLayerConnection.isVideoOrientationSupported {
                  switch (orientation) {
                  case .portrait:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                    break
                  case .landscapeRight:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeLeft)
                    break
                  case .landscapeLeft:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeRight)
                    break
                  case .portraitUpsideDown:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .portraitUpsideDown)
                    break
                  default:
                    updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                    break
                  }
                }
          }
    }
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    // Run Vision code with live stream
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        var requestOptions: [VNImageOption : Any] = [:]
        
        if let camData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
            requestOptions = [.cameraIntrinsics : camData]
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: requestOptions)
        
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
}


