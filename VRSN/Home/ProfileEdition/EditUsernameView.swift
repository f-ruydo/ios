//
//  EditUsernameView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI
import Combine

struct EditUsernameView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var myCurrentUser: GetUsersViewModel
    @ObservedObject private var editProfileVM = EditProfileViewModel()
    @State private var newUsername = ""
        
    private let usernameLimit = 25
    
    func limitText(_ upper: Int) {
        if newUsername.count > upper {
            newUsername = String(newUsername.prefix(upper))
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Username:")
                .font(.callout)
                .foregroundColor(.gray)
            TextField("", text: $newUsername).onAppear() {
                self.newUsername = myCurrentUser.user!.username
            }
                .autocapitalization(.none)
                .textCase(.lowercase)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive(Just(newUsername)) { _ in limitText(usernameLimit) }
                
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    editProfileVM.changeUsername(currentUserId: myCurrentUser.user!.userId, newUsername: newUsername.lowercased())
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct EditUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        EditUsernameView()
            .environmentObject(GetUsersViewModel())
    }
}
