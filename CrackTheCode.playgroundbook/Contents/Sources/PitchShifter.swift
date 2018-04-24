import Foundation
import AVFoundation

public class PitchShifter {
    
    private let audioPlayer: AVAudioPlayer!
    private let audioEngine: AVAudioEngine!
    private var audioFile: AVAudioFile!
    
    public init(filePath: String, file: AVAudioFile) {
        audioFile = file
        audioPlayer = try! AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: filePath))
        audioPlayer.enableRate = true
        audioPlayer.prepareToPlay()
        audioEngine = AVAudioEngine()
    }
    
    // Shifts and then plays the tone
    public func playAudioWithVariablePitch(_ pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let node = AVAudioPlayerNode()
        audioEngine.attach(node)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attach(changePitchEffect)
        
        audioEngine.connect(node, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        node.scheduleFile(audioFile, at: nil, completionHandler: nil)
        
        try! audioEngine.start()
        node.play()
    }
    
    // Stops the tone when it is playing
    public func stopPlaying() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}

