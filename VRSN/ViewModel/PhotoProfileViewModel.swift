//
//  PhotoProfileViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Firebase

class PhotoProfileViewModel: ObservableObject {
    
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
    func uploadPhoto(data: Data, userId: String, completion: @escaping (URL?) -> Void) {
        
        let picName = userId
        let storageRef = storage.reference()
        let photoRef = storageRef.child("userPic/\(picName).png")
        
        photoRef.putData(data, metadata: nil) { metadata, error in
            photoRef.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    completion(url)
                }
            }
        }
    }
    
    func save(url: URL) {
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let batch = db.batch()
        
        let userRef = db.collection("users").document(currentUserId)
        batch.updateData(["photoUrl" : url.absoluteString], forDocument: userRef)
        
        batch.commit() {err in
            if let err = err {
                print("Error saving photoProfile batch \(err)")
            } else {
                print("Saved photoProfile successfully.")
            }
        }
    }
}
