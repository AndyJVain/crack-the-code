/*:
 * callout(Goal):
 Learn how to quickly solve the Caesar cipher and crack the [ciphertext](glossary://ciphertext).
 
 Reading a message coded by the Caesar cipher might look difficult to break, but we can easily get the original message by using some simple programming.
 
 Since the Caesar cipher shifts each letter in the message by a certain amount, we just have to check every possible shift. This process can be tedious if done by hand, so instead, we can use a loop to quickly [iterate](glossary://iterate) over each shift.
 
 * callout(Note):
 A loop has already been written below. Simply adjust the number of iterations to shift over all possible letters.
 
 **Hint:**
 1. Think about how many times you will need to run the loop. How many ways can you shift a letter?
 2. It sounds like you will need to check every letter of the alphabet...
 
 First, set the correct number of iterations, then `next` and `previous` buttons will appear. Use them to cycle through each shift until you can read the message!
 */
//#-hidden-code
import PlaygroundSupport

let cipher = CaesarCipher()
let vc = SolveViewController.loadFromStoryboard() as! SolveViewController
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = vc

let ciphertext = vc.secretMessage

func shift(_ message: String, by shift: Int) {
    let shiftedMessage = cipher.makeCipher(with: message, shiftedBy: shift)
    vc.addMessage(shiftedMessage)
}

// Used to determine when the page is successfully completed
func reportStatus(_ status: SolveViewController.CompletionStatus) {
    switch status {
    case .failedIncorrectLoopIterations:
        PlaygroundPage.current.assessmentStatus = .fail(hints: ["Make sure you shift over every possible letter."], solution: "There are 26 letters in the alphabet and you need to shift over each one. Set `total = 26`")
    case .failedNotViewingCorrectShift:
        return
    case .success:
        PlaygroundPage.current.assessmentStatus = .pass(message: "### Congrats!\nYou solved the cipher to find the secret message! [**Tap here**](@next) to go to the next page and see a unique way to send a secret message.")
    }
}
vc.reportStatus = reportStatus
//#-code-completion(everything, hide)
//#-end-hidden-code
// Number of times to run the loop
let total = /*#-editable-code*/<#T##number of iterations##Int#>/*#-end-editable-code*/

for i in 1...total {
    shift(ciphertext, by: i)
}
//#-hidden-code
vc.unhideButtons()
//#-end-hidden-code

