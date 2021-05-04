//
//  Home2View.swift
//  VRSN
//
//  Created by Enrique on 04-05-21.
//

import SwiftUI
import Firebase

struct Home2View: View {
    
    let uId = Auth.auth().currentUser!.uid
    @State var selectedTab = 3
    
    var body: some View {
        
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
            
 /*           UserView(observedUserId: uId)
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(4) */
        }
    }
}

struct Home2View_Previews: PreviewProvider {
    static var previews: some View {
        Home2View()
    }
}
