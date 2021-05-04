//
//  FirestoreManager.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Firebase

class FirestoreManager {
    
    let db = Firestore.firestore()
    
    func getAudiosFeed(userIdArray: Array<String>, completion: @escaping (Result<[Audio]?, Error>) -> Void) {
        
        if userIdArray.count == 0 {
            return
        }
        
        db.collection("audios").whereField("userId", in: userIdArray)
            .order(by: "creationDate", descending: true)
            .addSnapshotListener { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        let audios: [Audio]? = snapshot.documents.compactMap { doc in
                            var audio = try? doc.data(as: Audio.self)
                            if audio != nil {
                                audio!.id = doc.documentID
                            }
                            return audio
                        }
                        completion(.success(audios))
                    }
                }
            }
    }
    
    func getAudiosByUserId(userId: String, completion: @escaping (Result<[Audio]?, Error>) -> Void) {
        
        db.collection("audios").whereField("userId", isEqualTo: userId)
            .order(by: "creationDate", descending: true)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        let audios: [Audio]? = snapshot.documents.compactMap { doc in
                            var audio = try? doc.data(as: Audio.self)
                            if audio != nil {
                                audio!.id = doc.documentID
                            }
                            return audio
                        }
                        completion(.success(audios))
                    }
                }
            }
    }
    
    
    func getUserById(userId: String, completion: @escaping (Result<User?, Error>) -> Void) {
        
        db.collection("users").document(userId)
            .addSnapshotListener { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        var user: User? = try? snapshot.data(as: User.self)
                        if user != nil {
                            user!.id = snapshot.documentID
                            completion(.success(user))
                        }
                    }
                }
            }
    }
    
    func getAudioById(audioId: String, completion: @escaping (Result<Audio?, Error>) -> Void) {
        
        let ref = db.collection("audios").document(audioId)
        ref.getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let snapshot = snapshot {
                    var audio: Audio? = try? snapshot.data(as: Audio.self)
                    if audio != nil {
                        audio!.id = snapshot.documentID
                        completion(.success(audio))
                    }
                }
            }
        }
    }
    
}
