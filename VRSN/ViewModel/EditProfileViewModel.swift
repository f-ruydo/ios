//
//  EditProfileViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Firebase

class EditProfileViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    func changeDisplayName(currentUserId: String, newDisplayName: String) {
        
        let batch = db.batch()
        
        let userRef = db.collection("users").document(currentUserId)
        batch.updateData(["displayName" : newDisplayName], forDocument: userRef)
        
        let usersDetailRef = db.collection("usersDetail").document(currentUserId)
        batch.updateData(["lastDisplayNameChange" : Date()], forDocument: usersDetailRef)
        
        batch.commit() {err in
            if let err = err {
                print("Error changing displayName batch \(err)")
            } else {
        //        print("New displayName Batch write succeeded.")
            }
        }
    }
    
    func changeUsername(currentUserId: String, newUsername: String) {
        
        let batch = db.batch()
        
        let userRef = db.collection("users").document(currentUserId)
        batch.updateData(["username" : newUsername], forDocument: userRef)
        
        let usersDetailRef = db.collection("usersDetail").document(currentUserId)
        batch.updateData(["lastUsernameChange" : Date()], forDocument: usersDetailRef)
        
        batch.commit() {err in
            if let err = err {
                print("Error changing username batch \(err)")
            } else {
        //        print("New username Batch write succeeded.")
            }
        }
    }
    
    func changeBio(currentUserId: String, newBio: String) {
        
        let batch = db.batch()
        
        let userRef = db.collection("users").document(currentUserId)
        batch.updateData(["bio" : newBio], forDocument: userRef)
        
        let usersDetailRef = db.collection("usersDetail").document(currentUserId)
        batch.updateData(["lastBioChange" : Date()], forDocument: usersDetailRef)
        
        batch.commit() {err in
            if let err = err {
                print("Error changing bio batch \(err)")
            } else {
        //        print("New bio Batch write succeeded.")
            }
        }
    }
}
