//
//  HomeView.swift
//  VRSN
//
//  Created by Enrique on 03-05-21.
//

import SwiftUI
import URLImage
import Firebase

struct HomeView: View {
    
    let uId = Auth.auth().currentUser!.uid
    @StateObject var myFollow = FollowViewModel()
    @StateObject var myCurrentUser = GetUsersViewModel()
    
    @State var selectedTab = 3
    
    var body: some View {
        
        VStack {
            if selectedTab != 2 {
                
                PlayerView(userId: "c43eNemibya54Xz4QSdWhAuN67I3", audioLength: 7000)
                
            }
            
            TabView(selection: $selectedTab) {
                
                TimelineView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(0)
                
                SearchView(selectedTab: $selectedTab)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(1)
                
                RecorderView()
                    .tabItem {
                        Image(systemName: "mic.circle.fill")
                        Text("REC")
                    }
                    .tag(2)
                
                NotificationsView()
                    .tabItem {
                        Image(systemName: "bell")
                    }
                    .tag(3)
                
                UserView(observedUserId: uId)
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(4) 
            }
            .environmentObject(myFollow)
            .environmentObject(myCurrentUser)
            .onAppear(perform: {
                myFollow.getFollowing(uId: uId)
                myFollow.getFollowers(uId: uId)
                myCurrentUser.getUserById(userId: uId)
            })
        }
    }
}

struct Home3View_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
