//
//  FollowViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Firebase

class FollowViewModel: ObservableObject {
    
    @Published var following: [String] = []
    @Published var followers: [String] = []
    
    private let db = Firestore.firestore()
    
    func getFollowing(uId: String) {
        
        let doc = db.collection("following").document(uId)
        
        doc.addSnapshotListener { (document, error) in
            
            let result = Result {
                try document?.data(as: Following.self)
            }
            
            switch result {
            case .success(let follow):
                if let follow = follow
                {
                    self.following = follow.following as [String]
                } else {
                    print("Following: Document does not exist")
                }
            case .failure(let error):
                print("Error decoding following: \(error)")
            }
        }
    }
    
    func getFollowers(uId: String) {
        
        let doc = db.collection("followers").document(uId)
        
        doc.addSnapshotListener { (document, error) in
            
            let result = Result {
                try document?.data(as: Followers.self)
            }
            
            switch result {
            case .success(let follow):
                if let follow = follow
                {
                    self.followers = follow.followers as [String]
                } else {
                    print("Followers: Document does not exist")
                }
            case .failure(let error):
                print("Error decoding followers: \(error)")
            }
        }
    }
    
    
    func follow(currentUserId: String, followUserId: String) {
        
        let batch = db.batch()
        
        let user1Ref = db.collection("users").document(currentUserId)
        batch.updateData(["following": FieldValue.increment(Int64(1))], forDocument: user1Ref)
        
        let followingRef = db.collection("following").document(currentUserId)
        batch.updateData(["following": FieldValue.arrayUnion([followUserId])], forDocument: followingRef)

        let user2Ref = db.collection("users").document(followUserId)
        batch.updateData(["followers": FieldValue.increment(Int64(1))], forDocument: user2Ref)
        
        let followersRef = db.collection("followers").document(followUserId)
        batch.updateData(["followers": FieldValue.arrayUnion([currentUserId])], forDocument: followersRef)
        
        batch.commit() {err in
            if let err = err {
                print("Error writing FOLLOW batch \(err)")
            } else {
                print("FOLLOW Batch write succeeded.")
            }
        }
    }
    
    func unFollow(currentUserId: String, followUserId: String) {
        
        let batch = db.batch()
        
        let user1Ref = db.collection("users").document(currentUserId)
        batch.updateData(["following": FieldValue.increment(Int64(-1))], forDocument: user1Ref)
        
        let followingRef = db.collection("following").document(currentUserId)
        batch.updateData(["following": FieldValue.arrayRemove([followUserId])], forDocument: followingRef)

        let user2Ref = db.collection("users").document(followUserId)
        batch.updateData(["followers": FieldValue.increment(Int64(-1))], forDocument: user2Ref)
        
        let followersRef = db.collection("followers").document(followUserId)
        batch.updateData(["followers": FieldValue.arrayRemove([currentUserId])], forDocument: followersRef)
        
        batch.commit() {err in
            if let err = err {
                print("Error writing UNFOLLOW batch \(err)")
            } else {
                print("UNFOLLOW Batch write succeeded.")
            }
        }
    }
}

