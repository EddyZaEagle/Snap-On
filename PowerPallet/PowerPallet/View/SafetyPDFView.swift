//
//  SafetyPDFView.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/1/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit
import PDFKit

class SafetyPDFView: PDFView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("one")
        setUpPDF()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpPDF()
    }
    
    private func setUpPDF() {
        self.backgroundColor = .snapOnRed
       if let path = Bundle.main.path(forResource: "FINAL_PowerPalletManual", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url: url) {
                self.displayMode = .singlePageContinuous
                self.autoScales = true
                // pdfView.displayDirection = .horizontal
                self.document = pdfDocument
            }
        }
        else {
            print("can't find file")
        }
    }

}
