//
//  AudioRecorderViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Combine
import AVFoundation

class AudioRecorderViewModel: NSObject, ObservableObject {
    
    var audioRecorder: AVAudioRecorder!
    let objectWillChange = PassthroughSubject<AudioRecorderViewModel, Never>()
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func getAudioFileUrl() -> URL {
        return FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask)[0].appendingPathComponent("audio.m4a")
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        let audioFilename = getAudioFileUrl()
        print("ruta audio: \(audioFilename)")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            recording = true
            
        } catch {
            print("Could not start recording: AudioRecorderViewModel.swift")
        }
    }
    
    func stopRecording() {
        if recording == true {
            audioRecorder.stop()
            recording = false
        }
    }
}
