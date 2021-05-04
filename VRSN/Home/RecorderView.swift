//
//  RecorderView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI
import Combine

struct RecorderView: View {
  
    @EnvironmentObject var myCurrenteUser: GetUsersViewModel
    
    @State private var title = ""

    @ObservedObject private var timerManagerVM = TimerManagerViewModel()
    @ObservedObject private var audioRecorderVM = AudioRecorderViewModel()
    @ObservedObject private var upLoadAudioVM = UpLoadAudioViewModel()
    
    
// Duración mínima audio
    
    var secondsMin = 2
    
    func upload(audioLength: Int) {
        let localFolder = audioRecorderVM.getAudioFileUrl().absoluteString
        upLoadAudioVM.uploadAudio(url: localFolder) { (url) in
            if let url = url {
                upLoadAudioVM.saveAudio(userId: myCurrenteUser.user!.userId, audioLength: audioLength, title: title, url: url)
                title = ""
            }
        }
    }

    // Function to keep length text in limits
    
    let titleLimit = 110
    
    private func limitText(_ upper: Int) {
        if title.count > upper {
            title = String(title.prefix(upper))
        }
    }
    
    var body: some View {
        
        VStack {
       
            Text("Voice Recorder")
                .font(.custom("Consolas", size: 40))
            
            Spacer()
            
            Text(timerManagerVM.seconds.secondsToMinutesAndSeconds())
                .font(.custom("Consolas", size: 60))

            Spacer()
            
            HStack {
                Spacer()
                
                VStack {
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipped()
                        .foregroundColor(.red)
                        .onTapGesture(perform: {
                            if timerManagerVM.timerMode == .initial || timerManagerVM.timerMode == .paused {
                                self.timerManagerVM.setTimerLength(minutes: 0)
                                self.timerManagerVM.start()
                                self.audioRecorderVM.startRecording()
                            }
                        })
                    
                    Text("REC").foregroundColor(.red)
            
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipped()
                        .foregroundColor(.black)
                        .onTapGesture {
                            self.timerManagerVM.pause()
                            self.audioRecorderVM.stopRecording()
                        }
                    
                    Text("STOP")
                }
                
                Spacer()
            }
            
            TextField("Audio title (optional)", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical)
                .onReceive(Just(title)) { _ in limitText(titleLimit) }
            
            if timerManagerVM.timerMode == .paused && timerManagerVM.seconds >= secondsMin {
                
                Button(action: {
                    upload(audioLength: self.timerManagerVM.seconds)
                    print(self.timerManagerVM.seconds)
                    self.timerManagerVM.reset()
                    
                }, label: {
                    
                    Text("Publish Audio ")
                    Image(systemName: "icloud.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                    
                })
            } else {
                HStack {
                Text("Publish Audio ")
                Image(systemName: "icloud.and.arrow.up")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                }.foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("Reset / Cancel")
                .foregroundColor(.red)
                .onTapGesture {
                    self.timerManagerVM.reset()
                    self.audioRecorderVM.stopRecording()
                    title = ""
                }
        }
        .padding()
    }
    
    
  
}

struct RecorderView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView()
            .environmentObject(GetUsersViewModel())
    }
}
