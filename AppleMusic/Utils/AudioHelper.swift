//
//  AudioHelper.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 13/12/21.
//
import AVFoundation

class AudioHelper {
    static let shared = AudioHelper()
    private var audioPlayer = AVAudioPlayer()
    
    func playAudio(audioURL: URL) {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback)
        } catch {
            print(error.localizedDescription)
        }
        
        audioPlayer.play()
    }
    
    func stopAudio() {
        audioPlayer.stop()
    }
    
    func getCurrentTime() -> TimeInterval {
        return audioPlayer.currentTime
    }
}
