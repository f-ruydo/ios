//
//  UpLoadAudioViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Firebase

class UpLoadAudioViewModel: ObservableObject {
    
    let storage = Storage.storage()
    let db = Firestore.firestore()

    func saveAudio(userId: String, audioLength: Int, title: String, url: URL) {
        
        let doc = db.collection("audios").document()
        let audioId = doc.documentID
        
        let batch = db.batch()
 
        let newAudioRef = db.collection("audios").document(audioId)
        batch.setData([
            "audioLength" : audioLength,
            "creationDate" : Date(),
            "likes" : 0,
            "title" : title,
            "url" : url.absoluteString,
            "userId" : userId,
            "userIdLikes" : Array<String>()
        ], forDocument: newAudioRef)
 
        let audiosCountRef = db.collection("users").document(userId)
        batch.updateData(["audios": FieldValue.increment(Int64(1))], forDocument: audiosCountRef)
        
        batch.commit() {err in
            if let err = err {
                print("Error writing SAVE AUDIO batch \(err)")
            } else {
                print("SAVE AUDIO Batch write succeeded.")
            }
        }
    }
    
    func uploadAudio(url: String, completion: @escaping (URL?) -> Void) {
        
        guard let fileUrl = URL(string: url) else {
                return
            }
        let audioName = UUID().uuidString
        let storageRef = storage.reference()
        let audioRef = storageRef.child("audios/\(audioName).m4a")
        
        audioRef.putFile(from: fileUrl, metadata: nil) { metadata, error in
            audioRef.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    completion(url)
                }
            }
        }
    }
}
