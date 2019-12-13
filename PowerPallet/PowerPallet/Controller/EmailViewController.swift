//
//  EmailViewController.swift
//  PowerPallet
//
//  Created by Adam Moreno on 12/2/19.
//  Copyright © 2019 Adam Moreno. All rights reserved.
//

import UIKit
import MessageUI

protocol EmailVCProtocol {
    var failedSpecs: [SafetyCheckClass] { get }
}

class EmailViewController: UIViewController {
    
    @IBOutlet weak var navBarEmail: EmailNavigationBar!
    @IBOutlet weak var tvEmail: UITableView!
    @IBOutlet weak var viewSendButton: EmailSendView!
    @IBOutlet weak var stvEmail: UIStackView!
    @IBOutlet weak var btnSend: UIButton!
    
    var emailProtocol: EmailVCProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tvEmail.delegate = self
        tvEmail.dataSource = self
        
        let emailNavBarDelegate = stvEmail.subviews[0] as! EmailNavigationBar
        emailNavBarDelegate.emailProtocol = self
        
        let emailSendDelegate = stvEmail.subviews[2] as! EmailSendView
        emailSendDelegate.sendProtolcol = self
        
        loadArray()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func sendEmailButton() {
        print("Send email")
    }
    
    private func loadArray() {
        
    }

}

extension EmailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailProtocol!.failedSpecs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emailCell")
        
        cell?.textLabel?.text = emailProtocol!.failedSpecs[indexPath.row].safetySpecification
        
        return cell!
    }
    
    
}

extension EmailViewController: EmailProtocol, SendProtocol, MFMailComposeViewControllerDelegate {
    func sendEmail() {
        let mailVC = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailVC, animated: true, completion: nil)
        }
        else {
            print("error! can not present email compose view controller..??")
        }
    }
    
    func didTapBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureMailController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["clpowerpalletchecklist@gmail.com"])
        //        mailComposerVC.setToRecipients(["clpowerpalletchecklist@gmail.com", "john.a.loacker@snapon.com", "david.e.hart@snapon.com"])
        mailComposerVC.setSubject("ForkLift #\("powerPallet") Issue")
        mailComposerVC.setMessageBody("sc.creatMessageBody()", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        var guide = " "
        switch result {
        case .sent:
            guide = "send"
        case .cancelled:
            guide = "not"
        case .saved:
            guide = "not"
        case .failed:
            guide = "not"
        @unknown default:
            fatalError()
        }
        
        if (guide == "send")
        {
            controller.dismiss(animated: true, completion: {
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            })
        }
        else
        {
            controller.dismiss(animated: true, completion: nil)
        }
    }
}
