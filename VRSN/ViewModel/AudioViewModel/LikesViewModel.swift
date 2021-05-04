//
//  LikesViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Firebase

class LikesViewModel: ObservableObject {
    
    @Published var likes: [String] = []
    
    private let db = Firestore.firestore()
 
    func like(audioId: String, userId: String) {
     
        let batch = db.batch()
        
        let audioRef = db.collection("audios").document(audioId)
        batch.updateData(["likes" : FieldValue.increment(Int64(1))], forDocument: audioRef)
        
        let audiosLikesRef = db.collection("audios").document(audioId)
        batch.updateData(["userIdLikes": FieldValue.arrayUnion([userId])], forDocument: audiosLikesRef)
        
        batch.commit() {err in
            if let err = err {
                print("Error writing LIKE batch \(err)")
            } else {
                print("LIKE Batch write succeeded.")
            }
        }
    }
    
    func unLike(audioId: String, userId: String) {
        
        let batch = db.batch()
        
        let audioRef = db.collection("audios").document(audioId)
        batch.updateData(["likes" : FieldValue.increment(Int64(-1))], forDocument: audioRef)
        
        let audiosLikesRef = db.collection("audios").document(audioId)
        batch.updateData(["userIdLikes": FieldValue.arrayRemove([userId])], forDocument: audiosLikesRef)
        
        batch.commit() {err in
            if let err = err {
                print("Error deleting LIKE batch \(err)")
            } else {
                print("unLIKE Batch write succeeded.")
            }
        }
    }
}
