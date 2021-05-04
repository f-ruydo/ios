//
//  ProfileView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI
import URLImage

enum SourceType {
    case photoLibrary
    case camera
}

struct ProfileView: View {

    @State private var showActionSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: SourceType = .photoLibrary
    @State private var image: Image? = nil
    @State private var originalImage: UIImage? = nil
    
    @StateObject private var photoProfileVM = PhotoProfileViewModel()
    
    @EnvironmentObject var myCurrentUser: GetUsersViewModel
    @ObservedObject private var authVM = AuthenticationViewModel()
    
    private func savePhotoProfile() {
        
        if let originalImage = originalImage {
            if let resizedImage = originalImage.resized(width: 360) {
                if let data = resizedImage.pngData() {
                    photoProfileVM.uploadPhoto(data: data, userId: myCurrentUser.user!.userId) { (url) in
                        if let url = url {
                            photoProfileVM.save(url: url)
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                if myCurrentUser.user!.photoUrl == "" {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .cornerRadius(120)
                        .opacity(0.5)
                    
                } else {
                    if let url = URL(string: myCurrentUser.user!.photoUrl) {
                        URLImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipped()
                                .cornerRadius(120)
                        }
                    }
                }
                Button(action: {
                    showActionSheet = true
                }, label: {
                    Text("Change Photo Profile")
                        .font(.footnote)
                })
                
                Form {
                    
                    Section {
                        HStack {
                            Text("Name")
                                .font(.footnote)
                                .frame(width: 80, alignment: .leading)
                            
                            NavigationLink(
                                destination: EditDisplayNameView(),
                                label: {
                                    Text(myCurrentUser.user!.displayName)
                                        .font(.footnote)
                                        .frame(alignment: .leading)
                                        .foregroundColor(.gray)
                                })
                        }
                        
                        HStack {
                            Text("Username")
                                .font(.footnote)
                                .frame(width: 80, alignment: .leading)
                            
                            NavigationLink(
                                destination: EditUsernameView(),
                                label: {
                                    Text(myCurrentUser.user!.username)
                                        .font(.footnote)
                                        .frame(alignment: .leading)
                                        .foregroundColor(.gray)
                                })
                            
                        }
                        
                        HStack(alignment: .top) {
                            Text("Bio")
                                .font(.footnote)
                                .frame(width: 80, alignment: .leading)
                            
                            NavigationLink(
                                destination: EditBioView(),
                                label: {
                                    Text(myCurrentUser.user!.bio)
                                        .font(.footnote)
                                        .frame(alignment: .leading)
                                        .foregroundColor(.gray)
                                })
                        }
                    }
                    
                    Section {
                        Button(action: {
                            print("Personal Information")
                        }) {
                            Text("Personal Information")
                                .font(.footnote)
                        }
                        Button(action: {
                            print("Send a message to Ruydo")
                        }) {
                            Text("Send a message to Ruydo")
                                .font(.footnote)
                        }
                    }
                }
                
                Button(action: {
                    authVM.logOut()
                }, label: {
                    Text("LogOut")
                        .fontWeight(.thin)
                })
            }
            .padding(.vertical)
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(title: Text("Select"), message: nil, buttons: [
                    .default(Text("Photo Library")) {
                        showImagePicker = true
                        sourceType = .photoLibrary
                    },
                    .default(Text("Camera")) {
                        showImagePicker = true
                        sourceType = .camera
                    },
                    .cancel()
                ])
            })
            .sheet(isPresented: $showImagePicker, content: {
                PhotoCaptureView(showImagePicker: $showImagePicker, image: $image, originalImage: $originalImage, sourceType: sourceType)
            })
            
            if image != nil {
                PhotoPreviewView(image: $image, save: {
                    savePhotoProfile()
                })
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), radius: 16, x: -8, y: -8)
                .shadow(color: Color(#colorLiteral(red: 0.904804647, green: 0.9049565196, blue: 0.904784739, alpha: 1)), radius: 16, x: 8, y: 8)
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(GetUsersViewModel())
    }
}

struct PhotoPreviewView: View {
    
    @Binding var image: Image?
    let save: () -> Void
    
    var body: some View {
        
        ZStack {
            VStack {
                image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                
                
                HStack {
                    
                    Button("Cancel") {
                     //   save()
                        image = nil
                    }.buttonStyle(SecondaryButtonStyle())
                    
                    Button("Save") {
                        save()
                        image = nil
                    }.buttonStyle(PrimaryButtonStyle())
                    
                }
                
            }.padding()
        }.background(Color(#colorLiteral(red: 0.904804647, green: 0.9049565196, blue: 0.904784739, alpha: 1)))
        .cornerRadius(10)
        //   .offset(y: 0)
        .padding()
        
    }
}
