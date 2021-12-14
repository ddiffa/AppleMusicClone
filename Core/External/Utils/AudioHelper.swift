//
//  AudioHelper.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 13/12/21.
//
import AVFoundation

public class AudioHelper {
    public static let shared = AudioHelper()
    private var audioPlayer = AVPlayer()
    private let audioSession = AVAudioSession.sharedInstance()
    public var isPlaying: Bool = false
    
    public func playAudio(audioURL: URL) {
        let playerItem:AVPlayerItem = AVPlayerItem(url: audioURL)
        audioPlayer = AVPlayer(playerItem: playerItem)
        if audioPlayer.rate == 0 {
            do {
                try audioSession.setCategory(.playback)
            } catch {
                print(error.localizedDescription)
            }
            audioPlayer.play()
            self.isPlaying = true
        } else {
            audioPlayer.pause()
        }
    }
    
    public func getAudioRate() -> Float {
        return self.audioPlayer.rate
    }
    
    public func stopAudio() {
        let targetTime:CMTime = CMTimeMake(value: 0, timescale: 1)
        audioPlayer.seek(to: targetTime)
        audioPlayer.pause()
        self.isPlaying = false
    }
    
    public func observePlayingTime(onPlaying: @escaping(Float64) -> Void,
                                   onBuffering: @escaping(Bool) -> Void,
                                   onNext: @escaping(Double) -> Void) {
        audioPlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1),
                                            queue: DispatchQueue.main) { currentTime in
            
            if self.audioPlayer.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.audioPlayer.currentTime());
                onPlaying(time)
            }
            
            let playbackLikelyToKeepUp = self.audioPlayer.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false {
                onBuffering(true)
            } else {
                onBuffering(false)
                
            }
            onNext(currentTime.seconds)
        }
    }
}
