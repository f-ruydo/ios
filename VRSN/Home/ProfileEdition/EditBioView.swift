//
//  EditBioView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI
import Combine

struct EditBioView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var myCurrentUser: GetUsersViewModel
    @ObservedObject private var editProfileVM = EditProfileViewModel()
    @State private var newBio = ""
        
    private let bioLimit = 150
    
    func limitText(_ upper: Int) {
        if newBio.count > upper {
            newBio = String(newBio.prefix(upper))
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Bio:")
                .font(.callout)
                .foregroundColor(.gray)
            TextEditor(text: $newBio).onAppear() {
                self.newBio = myCurrentUser.user!.bio }
                .onReceive(Just(newBio)) { _ in limitText(bioLimit) }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(.systemGray5), lineWidth: 1.0)
                )
                .frame(minHeight: 20, maxHeight: 140)
            
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    editProfileVM.changeBio(currentUserId: myCurrentUser.user!.userId, newBio: newBio)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct EditBioView_Previews: PreviewProvider {
    static var previews: some View {
        EditBioView()
            .environmentObject(GetUsersViewModel())
    }
}
