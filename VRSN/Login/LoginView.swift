//
//  LoginView.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import SwiftUI

struct LoginView: View {

    @ObservedObject var model = AuthenticationViewModel()
    
    var body: some View{
        ZStack{
            VStack{
                Spacer(minLength: 0)
                
                Image("ruydo amarillo")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, -10)
                     
                Text("Ruydo")
                    .font(.system(size: 35, weight: .heavy))
                    .foregroundColor(.white)
                    .padding(.top, -20)
                    
                VStack(spacing: 20){
                    
                    CustomTextField(image: "person", placeHolder: "Email", txt: $model.email)
                        .autocapitalization(.none)
                    
                    CustomTextField(image: "lock", placeHolder: "Password", txt: $model.password)
                }
                .padding(.top)
                
                Button(action: {
                    
                    model.login()
                
                }) {
                    
                    Text("LOGIN")
                        .fontWeight(.bold)
                        .foregroundColor(Color("BG1"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top,22)
                
                HStack(spacing: 12){
                    
                    Text("Don't have an account?")
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Button(action: {model.isSignUp.toggle()}) {
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top,25)
                
                Spacer(minLength: 0)
                
                Button(action: model.resetPassword) {
                    Text("Forget Password?")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.vertical,22)
            }
            
            if model.isLoading{
                LoadingView()
            }
        }
        .background(LinearGradient(gradient: .init(colors: [Color.white,Color("BG1")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .fullScreenCover(isPresented: $model.isSignUp) {
            
            SignUpView(model: model)
        }
        // Alerts...
        .alert(isPresented: $model.alert, content: {
            
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok")))
        })
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
