//
//  ContentView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @AppStorage ("log_Status") var log_Status = false
    
    let uId = Auth.auth().currentUser!.uid
    
    var body: some View {
        
        ZStack{
            
            if !log_Status {
                
                LoginView()
                
            }
            else {

                HomeView()
              
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
