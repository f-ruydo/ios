//
//  PlayerView.swift
//  VRSN
//
//  Created by Enrique on 03-05-21.
//

import SwiftUI
import URLImage

struct PlayerView: View {
    
    var userId: String
    var audioLength: Int
    
    @State private var time = 0.0
    @State private var isEditing = false
    @StateObject var getUser = GetUsersViewModel()
    var body: some View {
        
        VStack {
            HStack(spacing: 10) {
                
                if let photoUrl = getUser.user?.photoUrl {
                    if photoUrl == "" {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .opacity(0.5)
                        
                    } else {
                        URLImage(url: URL(string: photoUrl)!) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                    }
                    
                } else {
                    
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .opacity(0.5)

                }
                
                Spacer()
                VStack {
                    
                    Text(getUser.user?.username ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    HStack(spacing: 25) {
                        Image(systemName: "gobackward.10")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        
                        Image(systemName: "backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        
                        Image(systemName: "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        
                        Image(systemName: "forward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        
                        Image(systemName: "goforward.10")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                    }
                    
                }
                Spacer()
                HStack(spacing: 20) {
                    Image(systemName: "hands.clap")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                    
                }
            }
            .padding(.horizontal)
            
            Slider(
                value: $time,
                in: 0...Double(audioLength),
                step: 1,
                onEditingChanged: { editing in
                    isEditing = editing
                },
                minimumValueLabel: Text(Int(time).secondsToMinutesAndSeconds())
                    .font(.caption)
                    .fontWeight(.light),
                maximumValueLabel: Text(audioLength.secondsToMinutesAndSeconds())
                    .font(.caption)
                    .fontWeight(.light)
            ) {
                Text("Time")
                
            }
            .padding(.horizontal)
            
            Divider().accentColor(.black)
            
        }
        .onAppear {
            getUser.getUserById(userId: userId)
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(userId: "4XZPMl8HYjQ7Mc9xGjWPHZGyRQn1", audioLength: 7000)
    }
}
