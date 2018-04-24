//
//  MusicViewController.swift
//  WWDC Scholarship 2018
//
//  Created by Andy Vainauskas on 3/29/18.
//  Copyright © 2018 Andy Vainauskas. All rights reserved.
//

import UIKit
import AVFoundation

public class MusicViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    var message: String!
    var timer: Timer!
    var shifter: PitchShifter!
    var count = 0
    
    public enum CompletionStatus {
        case failedNoMessageEntered
        case success
    }
    
    public var currentStatus: CompletionStatus = .failedNoMessageEntered
    public typealias ReportStatus = (CompletionStatus) -> Void
    public var reportStatus: ReportStatus?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
        message = ""
        
        // Create the AVAudioFile for the tone using the filePath
        let filePath = Bundle.main.path(forResource: "tone", ofType: "mp3")
        let audioFile = try! AVAudioFile(forReading: URL.init(fileURLWithPath: filePath!))
        shifter = PitchShifter(filePath: filePath!, file: audioFile)
    }
    
    // Appends an individual character to the message label, "typing out" the entire message one letter at a time
    public func updateMessageLabel(withCharacter character: Character) {
        messageLabel.text?.append(character)
    }
    
    // Sets the message provided by the user
    public func setMessage(with newMessage: String) {
        self.message = newMessage
    }
    
    // Begins the timer (which begins playing a tone for each character in the message provided by the user)
    public func startTimer(withSpeed speed: Speed) {
        timer = Timer.scheduledTimer(timeInterval: speed.rawValue, target: self, selector: #selector(self.playTones), userInfo: nil, repeats: true)
    }
    
    // Used by the timer to play the tone and update the message label letter by letter
    @objc func playTones() {
        shifter.stopPlaying()
        
        // Checks to see if a message was entered to determine a "success" for the page assessmentStatus
        if let message = messageLabel.text {
            if message != "" {
                currentStatus = .success
            }
        }
        
        // Ends the timer when the entire message has been played
        if count == message.count {
            timer.invalidate()
            self.reportStatus?(self.currentStatus)
            return
        }
        
        if let prevMessage = messageLabel.text {
            let newCharacter = message[message.index(message.startIndex, offsetBy: count)]
            
            // Play the mapped tone if the character is a letter or the default tone for special characters
            if let pitch = characterPitches[newCharacter] {
                shifter.playAudioWithVariablePitch(pitch)
            } else {
                if newCharacter != " " {
                    shifter.playAudioWithVariablePitch(-2000)
                }
            }
            messageLabel.text = prevMessage + String(newCharacter)
        }
        count += 1
    }
}

public extension MusicViewController {
    class func loadFromStoryboard() -> UIViewController? {
        let storyboard = UIStoryboard.init(name: "Main3", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MusicVC") as! MusicViewController
    }
}
