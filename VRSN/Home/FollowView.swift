//
//  FollowView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI
import URLImage

struct FollowView: View {
    
    var observedUserId: String
    var followers: Array<String>
    var following: Array<String>
    
    @ObservedObject var uFollowers = GetUsersViewModel()
    @ObservedObject var uFollowing = GetUsersViewModel()
    
    @State var index = 0
    
    var body: some View {
        
        VStack {
            HStack(spacing: 0) {
                Button(action: {
                    index = 0
                }) {
                    VStack{
                        Text("\(followers.count) Followers")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(index == 0 ? .black : .gray)
                        
                        ZStack {
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame( height: 2)
                            
                            if index == 0 {
                                Capsule()
                                    .fill(Color("Follow_Color"))
                                    .frame( height: 2)
                            }
                        }
                    }
                }
                
                Button(action: {
                    index = 1
                }) {
                    VStack{
                        Text("\(following.count) Following")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(index == 1 ? .black : .gray)
                        
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame( height: 2)
                            
                            if index == 1 {
                                Capsule()
                                    .fill(Color("Follow_Color"))
                                    .frame( height: 2)
                            }
                        }
                    }
                }
            }.padding(.bottom)
            
            .padding(.top)
            
            ScrollView {
                VStack {
                    if index == 0 {
                        ForEach(uFollowers.users, id: \.id) { users in
                            UserBoxView(uId: users.id!, photoUrl: users.photoUrl, username: users.username, displayName: users.displayName)
                        }
                        
                    } else {
                        ForEach(uFollowing.users, id: \.id) { users in
                            UserBoxView(uId: users.id!, photoUrl: users.photoUrl, username: users.username, displayName: users.displayName)
                        }
                    
                    }
                }
                .onAppear {
                    uFollowers.getUsersFromArray(usersArray: followers)
                    uFollowing.getUsersFromArray(usersArray: following)
                }
            }
        }
    }
}

struct FollowView_Previews: PreviewProvider {
    static var previews: some View {
        FollowView(observedUserId: "jOHGduwBJUWUqnZbO0wZb7TqFKs1", followers: ["jOHGduwBJUWUqnZbO0wZb7TqFKs1"], following: ["USmyn6fi4dYrdemUKTPBLjkNxrU2","jOHGduwBJUWUqnZbO0wZb7TqFKs1"], index: 1)
    }
}

struct UserBoxView: View {
    
    @EnvironmentObject var myFollowing: FollowViewModel
    
    var uId: String
    var photoUrl: String
    var username: String
    var displayName: String?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                
                if photoUrl == "" {
                    Image("noFace")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                } else {
                    
                    URLImage(url: URL(string: photoUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Text(displayName ?? "")
                        .font(.caption)
                        .fontWeight(.light)
                    
                    
                     if myFollowing.following.contains(uId) {
                     Text("Following")
                     .font(.caption)
                     .fontWeight(.ultraLight)
                     }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
    }
}
