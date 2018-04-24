/*:
 * callout(Goal):
 Learn how to create a secret message using a [cipher](glossary://cipher).
 
 Have you ever thought about sending a coded message? Not only would you need a way to scramble the letters to prevent other people from reading it, but you also need to make sure the person receiving your message can unscramble it to read the original contents.
 
 This section will teach you about the Caesar cipher, a method for creating coded messages, used by Julius Caesar himself!
 
 * callout(Process):
 The Caesar cipher works like this:
 
 Each letter in the original message is shifted by an amount agreed upon by the sender and recipient. This is an example of symmetric-key encryption -- a method where the sender and receiver both need to have the same key in order to [encrypt](glossary://encrypt) and [decrypt](glossary://decrypt) the message.
 
 For example, using a shift of 4:
 
 a -> e
 
 b -> f
 
 c -> g
 
 etc.
 
 Try creating your own secret message by using entering a message and a shift value below.
 */
//#-hidden-code
import PlaygroundSupport

let cipher = CaesarCipher()
let vc = CaesarViewController.loadFromStoryboard() as! CaesarViewController
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = vc

func makeCaesarCode(with message: String, shiftedBy shift: Int) {
    let codedMessage = cipher.makeCipher(with: message, shiftedBy: shift)
    vc.updateLabels(withMessage: message, withCode: codedMessage)
}

// Used to determine when the page is successfully completed
func reportStatus(_ status: CaesarViewController.CompletionStatus) {
    switch status {
    case .failedNoMessageEntered:
        return
    case .success:
        PlaygroundPage.current.assessmentStatus = .pass(message: "### Great!\nYou just made a secret message using the Caesar cipher! [**Tap here**](@next) to go to the next page to see how to crack it.")
    }
}
vc.reportStatus = reportStatus
//#-end-hidden-code
//#-code-completion(everything, hide)
// Enter a short message
let message = /*#-editable-code*/""/*#-end-editable-code*/

// Enter a character shift value
let key = /*#-editable-code*/<#T##shift value##Int#>/*#-end-editable-code*/
//#-hidden-code
makeCaesarCode(with: message, shiftedBy: key)
//#-end-hidden-code
