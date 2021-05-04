//
//  GetUsersViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import Firebase

class GetUsersViewModel: ObservableObject {
    
    private var firestoreManager: FirestoreManager
    init() {
        firestoreManager = FirestoreManager()
    }
    
    @Published var user: UserViewModel?
    
    @Published var users: [User] = []
    
    private let db = Firestore.firestore()

    func getUsersFromArray(usersArray: Array<Any>) {
        if usersArray.count == 0 {
            return
        } else {
            
            db.collection("users").whereField(FieldPath.documentID(), in: usersArray)
                .addSnapshotListener { (QuerySnapshot, error) in
                    guard let documents = QuerySnapshot?.documents else {
                        print("Error fetching documents: \(error!)")
                        return
                    }
                    self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                        return try? queryDocumentSnapshot.data(as: User.self)
                    }
                }
        }
    }
    
    func getUserById(userId: String) {
        
        firestoreManager.getUserById(userId: userId) { result in
            switch result {
            case .success(let user):
                if let user = user {
                    DispatchQueue.main.async {
                        self.user = UserViewModel(user: user)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
