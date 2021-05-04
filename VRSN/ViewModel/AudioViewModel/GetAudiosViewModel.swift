//
//  GetAudiosViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Firebase

class GetAudiosViewModel: ObservableObject {
    
    @Published var audiosFeed: [AudioViewModel] = []
    @Published var audiosUser: [AudioViewModel] = []
 //   @Published var audio = AudioViewModel(audio: Audio(title: "", url: "", audioLength: 0, creationDate: Date(), likes: 0, userId: "", userIdLikes: [""]))
    
    @Published var audio: AudioViewModel?
    
    private var firestoreManager: FirestoreManager
    init() {
        firestoreManager = FirestoreManager()
    }

    func getFeed(userIdArray: Array<String>) {
        
        firestoreManager.getAudiosFeed(userIdArray: userIdArray) { result in
            switch result {
            case .success(let audios):
                if let audios = audios {
                    DispatchQueue.main.async {
                        self.audiosFeed = audios.map(AudioViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getAudiosByUserId(userId: String) {
        
        firestoreManager.getAudiosByUserId(userId: userId) { result in
            switch result {
            case .success(let audios):
                if let audios = audios {
                    DispatchQueue.main.async {
                        self.audiosUser = audios.map(AudioViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getAudioById(audioId: String) {
        
        firestoreManager.getAudioById(audioId: audioId) { result in
            switch result {
            case .success(let audio):
                if let audio = audio {
                    DispatchQueue.main.async {
                        self.audio = AudioViewModel(audio: audio)
                    }
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
