//
//  CaesarViewController.swift
//  WWDC Scholarship 2018
//
//  Created by Andy Vainauskas on 3/19/18.
//  Copyright © 2018 Andy Vainauskas. All rights reserved.
//

import UIKit

public class CaesarViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cipherLabel: UILabel!
    
    public enum CompletionStatus {
        case failedNoMessageEntered
        case success
    }
    
    public var currentStatus: CompletionStatus = .failedNoMessageEntered
    public typealias ReportStatus = (CompletionStatus) -> Void
    public var reportStatus: ReportStatus?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.alpha = 0.0
        cipherLabel.alpha = 0.0
        messageLabel.text = ""
        cipherLabel.text = ""
        initialAnimation()
    }
    
    // Updates the message and cipher labels
    public func updateLabels(withMessage message: String, withCode code: String) {
        messageLabel.text = message.uppercased()
        cipherLabel.text = code
        
        // Checks to see if a message was entered to determine a "success" for the page assessmentStatus
        if let message = messageLabel.text {
            if message != "" {
                currentStatus = .success
            }
        }
        
        // Delays the message reporting to wait for the animations to complete
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
            self.reportStatus?(self.currentStatus)
        }
    }
    
    // Fades in the message and cipher labels
    func initialAnimation() {
        UIView.animate(withDuration: 1.2, delay: 0.0, options: [], animations: {
            self.messageLabel.alpha = 1.0
        }, completion: nil)

        UIView.animate(withDuration: 1.2, delay: 0.5, options: [], animations: {
            self.cipherLabel.alpha = 1.0
        }, completion: nil)
    }
}

public extension CaesarViewController {
    class func loadFromStoryboard() -> UIViewController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "CaesarVC") as! CaesarViewController
    }
}
