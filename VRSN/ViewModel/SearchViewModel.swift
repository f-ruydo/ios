//
//  SearchViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Firebase

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    private let db = Firestore.firestore()
    
    func getAllUsers() {
        
        db.collection("users")
            .addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                return
            }
            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
                
        }
    }
}
