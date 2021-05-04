//
//  EditDisplayNameView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI
import Combine

struct EditDisplayNameView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var myCurrentUser: GetUsersViewModel
    @ObservedObject private var editProfileVM = EditProfileViewModel()
    @State private var newDisplayName = ""
        
    private let displayNameLimit = 25
    
    func limitText(_ upper: Int) {
        if newDisplayName.count > upper {
            newDisplayName = String(newDisplayName.prefix(upper))
        }
    }
    
    var body: some View {

        VStack(alignment: .leading) {
            Text("Name:")
                .font(.callout)
                .foregroundColor(.gray)
            TextField("", text: $newDisplayName).onAppear() {
                self.newDisplayName = myCurrentUser.user!.displayName
            }
               
        
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive(Just(newDisplayName)) { _ in limitText(displayNameLimit) }
                
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    editProfileVM.changeDisplayName(currentUserId: myCurrentUser.user!.userId, newDisplayName: newDisplayName)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct EditDisplayNameView_Previews: PreviewProvider {
    static var previews: some View {
        EditDisplayNameView()
            .environmentObject(GetUsersViewModel())
    }
}
