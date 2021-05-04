//
//  AudioPlayerViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Combine
import AVFoundation

class AudioPlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {

    @Published var urlPlaying: URL? = nil
    
    let objectWillChange = PassthroughSubject<AudioPlayerViewModel, Never>()
    var isPlaying = false {
            didSet {
                objectWillChange.send(self)
            }
        }

    var audioPlayer: AVAudioPlayer!
    var currentTime = 0.0
    
    func stopPlayback() {
        print("antes de parar isPlaying: \(isPlaying)")
        if isPlaying == true {
            audioPlayer.stop()
            isPlaying = false
            print("stop el audio \(isPlaying)")
        }
    }
 
    func pausePlayback() {
        print("Vamos a pausar, primer click")
        audioPlayer.pause()
        isPlaying = false
        currentTime = audioPlayer.currentTime
        print(currentTime)
    }

    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false

        }
    }
    
    func player(audioUrl: URL){
        
        isPlaying = true

        urlPlaying = audioUrl
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: audioUrl) { (url, response, error) in
            self.play(url: url!)
        }
        downloadTask.resume()
    }
    
    func play(url:URL) {
        
        do {
           
            audioPlayer = try AVAudioPlayer(contentsOf: url as URL)
            audioPlayer.prepareToPlay()
            // audioPlayer.volume = 2.0
            audioPlayer.play(atTime: 10)
            audioPlayer.delegate = self
            print(currentTime)
            print(audioPlayer.duration)
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
}
