//
//  SearchView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI
import URLImage

struct SearchView: View {
    @Binding var selectedTab: Int
    @State var searchQuery = ""
    
    @StateObject private var searchUsersVM = SearchViewModel()
    @EnvironmentObject var myFollowing: FollowViewModel
    @EnvironmentObject var myCurrenteUser: GetUsersViewModel
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack(spacing: 15) {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.gray)
                    
                    TextField("Search not implemented yet", text: $searchQuery)
                    
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.05))
                .cornerRadius(8)
               // .padding()
                
      //          Divider()
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(searchUsersVM.users, id: \.id) {users in
                            
                            if users.id != myCurrenteUser.user?.userId {
                                
                                NavigationLink(destination: UserView(observedUserId: users.id!)) {
                                    
                                    UserSearchBox(userId: users.id!, photoUrl: users.photoUrl, username: users.username, displayName: users.displayName, following: myFollowing.following)
                                    
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                            } else {
                                Button(action: {
                                    self.selectedTab = 4
                                    
                                }, label: {
                                    
                                    UserSearchBox(userId: users.id!, photoUrl: users.photoUrl, username: users.username, displayName: users.displayName, following: myFollowing.following)
                                    
                                })
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
     //       .navigationTitle("Search")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                        searchUsersVM.getAllUsers()})
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(selectedTab: .constant(4))
            .environmentObject(FollowViewModel())
            .environmentObject(GetUsersViewModel())
    }
}
#endif

struct UserSearchBox: View {
        
    let userId: String
    let photoUrl: String
    let username: String
    let displayName: String
    let following: Array<String>
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            if photoUrl == "" {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .opacity(0.5)
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
                
                Text(displayName)
                    .font(.caption)
                    .fontWeight(.light)
                
                if following.contains(userId) {
                    Text("Following")
                        .font(.caption)
                        .fontWeight(.ultraLight)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
