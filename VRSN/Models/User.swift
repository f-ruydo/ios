//
//  User.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var displayName: String
    var photoUrl: String
    var username: String
    var bio: String
    var followers: Int
    var following: Int
    var audios: Int
}

struct UserViewModel {
    
    let user: User
    
    var userId: String {
        user.id ?? ""
    }
    
    var displayName: String {
        user.displayName
    }
    
    var photoUrl: String {
        user.photoUrl
    }
    
    var username: String {
        user.username
    }
    
    var bio: String {
        user.bio
    }
    
    var followers: Int {
        user.followers
    }
    
    var following: Int {
        user.following
    }
    
    var audios: Int {
        user.audios
    }
}
