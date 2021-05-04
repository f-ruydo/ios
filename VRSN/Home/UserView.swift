//
//  UserView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI
import URLImage

struct UserView: View {
    
    var observedUserId: String

    @State private var sheet1 = false
    @State private var sheet2 = false
    @State private var sheet3 = false
    
    @StateObject var getUserByIdVM = GetUsersViewModel()
    @StateObject var followVM = FollowViewModel()
    
    @EnvironmentObject var myCurrentUser: GetUsersViewModel
    @EnvironmentObject var myFollowing: FollowViewModel
    
    var body: some View {
        
        let username: String = "@\(getUserByIdVM.user?.username ?? "")"
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                    
                        if let photoUrl = getUserByIdVM.user?.photoUrl {
                            if photoUrl == "" {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .opacity(0.5)
                            } else {
                                URLImage(url: URL(string: photoUrl)!) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                }
                            }
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .opacity(0.5)
                        }
                        Spacer()
                        VStack {
                            HStack {
                                VStack {
                                    Text("\(getUserByIdVM.user?.audios ?? 0)")
                                    Text("Audios")
                                        .font(.system(size: 12, design: .serif))
                                }
                                
                                VStack {
                                    Text("\(getUserByIdVM.user?.followers ?? 0)")
                                    Button(action: {
                                        sheet2.toggle()
                                    }, label: {
                                        Text("Followers")
                                            .font(.system(size: 12, design: .serif))
                                    })
                                    .sheet(isPresented: $sheet2, content: {
                                        FollowView(observedUserId: observedUserId, followers: followVM.followers, following: followVM.following, index: 0).environmentObject(myFollowing)
                                    })
                                }
                                
                                VStack {
                                    Text("\(getUserByIdVM.user?.following ?? 0)")
                                    Button(action: {
                                        sheet3.toggle()
                                    }, label: {
                                        Text("Following")
                                            .font(.system(size: 12, design: .serif))
                                    })
                                    .sheet(isPresented: $sheet3, content: {
                                        FollowView(observedUserId: observedUserId, followers: followVM.followers, following: followVM.following, index: 1).environmentObject(myFollowing)
                                    })
                                }
                            }
                        }
                        Spacer()
                        
                    }.padding(.horizontal)
                    .onAppear {
                        getUserByIdVM.getUserById(userId: observedUserId)
                        followVM.getFollowers(uId: observedUserId)
                        followVM.getFollowing(uId: observedUserId)
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text(getUserByIdVM.user?.displayName ?? "")
                            .font(.subheadline)
                            .bold()
                        Text(username)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(getUserByIdVM.user?.bio ?? "")
                            .font(.footnote)
                            .padding(.bottom, 5)
                        
                        if myCurrentUser.user?.username ?? "" == getUserByIdVM.user?.username ?? "" {
                            
                            NavigationLink(destination: ProfileView()) {
                                Text("Edit Profile")
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 25, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.gray).foregroundColor(.white).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            }
                            
                        } else if myFollowing.following.contains(observedUserId) {
                            Button(action: {
                                myFollowing.unFollow(currentUserId: myCurrentUser.user!.userId, followUserId: getUserByIdVM.user!.userId)
                            }, label:  {
                                Text("Unfollow")
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 25, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            })
                            .border(Color.gray, width: 2).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            
                        } else {
                            Button(action: {
                                myFollowing.follow(currentUserId: myCurrentUser.user!.userId, followUserId: getUserByIdVM.user!.userId)
                            }, label:  {
                                Text("Follow")
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 25, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            })
                            .background(Color.blue).foregroundColor(.white).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        }
                    }.padding([.leading, .bottom, .trailing])

                }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(observedUserId: "4XZPMl8HYjQ7Mc9xGjWPHZGyRQn1")
            .environmentObject(FollowViewModel())
            .environmentObject(GetUsersViewModel())
    }
}
