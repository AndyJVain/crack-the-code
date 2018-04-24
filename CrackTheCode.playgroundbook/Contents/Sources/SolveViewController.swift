//
//  SolveViewController.swift
//  WWDC Scholarship 2018
//
//  Created by Andy Vainauskas on 3/19/18.
//  Copyright © 2018 Andy Vainauskas. All rights reserved.
//

import UIKit

public class SolveViewController: UIViewController {
    
    @IBOutlet weak var shiftTitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    public let secretMessage = "Sio mifpyx nby wixy! Gusvy C'ff myy sio un QQXW nbcm syul? C'g lyuffs yrwcnyx ni fyulh uff uvion nby hyq miznquly ojxunym Ujjfy cm aicha ni uhhiohwy!"
    var shiftCount = 0
    var shiftedMessages: [String] = []
    var solved = false
    
    public enum CompletionStatus {
        case failedIncorrectLoopIterations
        case failedNotViewingCorrectShift
        case success
    }
    
    public var currentStatus: CompletionStatus = .failedNotViewingCorrectShift
    public typealias ReportStatus = (CompletionStatus) -> Void
    public var reportStatus: ReportStatus?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        shiftTitleLabel.text = "SHIFT \(shiftCount)"
        messageLabel.text = secretMessage.uppercased()
        shiftedMessages.insert(secretMessage, at: 0)
        prevButton.isHidden = true
        nextButton.isHidden = true
    }
    
    // Displays the previous shift message
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        if (shiftCount > 0 && shiftedMessages.count == 27) {
            shiftCount -= 1
            checkForActiveButtons()
            updateTitleLabel()
            updateMessage(with: shiftedMessages[shiftCount])
            initialAnimation()
        }
    }
    
    // Displays the next shift message
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if (shiftCount < 25 && shiftedMessages.count == 27) {
            shiftCount += 1
            checkForActiveButtons()
            updateTitleLabel()
            updateMessage(with: shiftedMessages[shiftCount])
            initialAnimation()
            
            if shiftCount == 6 && !solved {
                solved = true
                currentStatus = .success
                self.reportStatus?(self.currentStatus)
            }
        }
    }
    
    // Updates the message label with provided message
    public func updateMessage(with message: String) {
        messageLabel.text = message.uppercased()
    }
    
    // Handles the nextButton and prevButton highlights
    public func checkForActiveButtons() {
        if (shiftCount == 0) {
            prevButton.alpha = 0.80
            prevButton.isEnabled = false
        } else if (shiftCount == 25) {
            nextButton.alpha = 0.80
            nextButton.isEnabled = false
        } else {
            prevButton.alpha = 1.0
            prevButton.isEnabled = true
            nextButton.alpha = 1.0
            nextButton.isEnabled = true
        }
    }
    
    // Used at the start to unhide the buttons
    public func unhideButtons() {
        if (shiftedMessages.count == 27) {
            prevButton.isHidden = false
            nextButton.isHidden = false
            prevButton.alpha = 0.0
            nextButton.alpha = 0.0
            checkForActiveButtons()
            UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
                self.prevButton.alpha = 1.0
                self.nextButton.alpha = 1.0
            }, completion: nil)
        } else {
            currentStatus = .failedIncorrectLoopIterations
            self.reportStatus?(self.currentStatus)
        }
    }
    
    // Updates the shiftCount at the top of the view
    func updateTitleLabel() {
        shiftTitleLabel.text = "Shift \(shiftCount)"
    }
    
    // Adds a message to the shiftedMessages array (used in the user loop)
    public func addMessage(_ message: String) {
        shiftedMessages.append(message)
    }
    
    func initialAnimation() {
        messageLabel.alpha = 0.0
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
            self.messageLabel.alpha = 1.0
        }, completion: nil)
    }
}

public extension SolveViewController {
    class func loadFromStoryboard() -> UIViewController? {
        let storyboard = UIStoryboard.init(name: "Main2", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "SolveVC") as! SolveViewController
    }
}
