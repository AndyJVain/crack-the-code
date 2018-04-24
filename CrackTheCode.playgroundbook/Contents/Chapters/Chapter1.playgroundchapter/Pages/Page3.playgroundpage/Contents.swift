/*:
 * callout(Goal):
 Think about other ways to encrypt messages and data.
 
 I am currently majoring in computer engineering with a minor in music. I recently learned about various techniques that are used to secure data in my computer networks class. This got me thinking about other fun ways to encode messages, and I thought it would be interesting to combine both of my passions: coding and music.
 
 I have created an "encryption technique" that builds upon the basic process of the Caesar cipher - instead of shifting each letter to another letter, it is mapped to a tone. Then, each tone is played in sequence, providing a musical representation of the message.
 
 While this is not a secure technique by any means, it provides a simple and fun way to transmit a message, provided the reciever can interpret the tones and correctly re-map them to their corresponding letters.
  
 Send a musical message by entering one below. Try different words or phrases to see how they sound!
 */
//#-hidden-code
import PlaygroundSupport
import UIKit
import AVFoundation

// Setup the liveView
let vc = MusicViewController.loadFromStoryboard() as! MusicViewController
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = vc
//#-end-hidden-code
// Enter a short message here
let message = /*#-editable-code*/""/*#-end-editable-code*/
//#-hidden-code
let speed: Speed = .fast

// Used to determine when the page is successfully completed
func reportStatus(_ status: MusicViewController.CompletionStatus) {
    switch status {
    case .failedNoMessageEntered:
        return
    case .success:
        PlaygroundPage.current.assessmentStatus = .pass(message: "### Fantastic!\nThank you for checking out my Swift Playground Book, I hope you enjoyed learning about ciphers. Now you can start thinking about even more ways you could send a secret message!")
    }
}
vc.reportStatus = reportStatus
vc.setMessage(with: message.uppercased())
vc.startTimer(withSpeed: speed)
//#-end-hidden-code
