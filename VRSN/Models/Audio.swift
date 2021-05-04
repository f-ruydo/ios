//
//  Audio.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import FirebaseFirestoreSwift

struct Audio: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var url: String
    var audioLength: Int
    var creationDate: Date
    var likes: Int
    var userId: String
    var userIdLikes: [String]
}

struct AudioViewModel {
    
    let audio: Audio
    
    var audioId: String {
        audio.id ?? ""
    }
    
    var title: String {
        audio.title
    }
    
    var url: String {
        audio.url
    }
    
    var audioLength: Int {
        audio.audioLength
    }
    
    var creationDate: Date {
        audio.creationDate
    }
    
    var likes: Int {
        audio.likes
    }
    
    var userId: String {
        audio.userId
    }
    
    var userIdLikes: [String] {
        audio.userIdLikes
    }
}
