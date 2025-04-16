//
//  LoginView.swift
//  UberSwiftUI
//
//  Created by Nitin on 17/04/25.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            
            VStack(spacing: 40){
                //image entitled Uber
                
                VStack{
                    Image(.uberLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130)
                    
                    Text("UBER")
                        .foregroundStyle(.white)
                        .font(.system(size: 30, weight: .bold))
                }
                
                //input Field
                
                VStack(spacing: 32){
                    
                    //inputField : 1
                    VStack(alignment: .leading,spacing: 12){
                        Text("Email Address")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .font(.footnote)
                        
                        TextField("name@example.com", text: $email)
                            .foregroundStyle(.white)
                         
                        
                        Rectangle()
                            .foregroundStyle(Color(.init(Color(white: 1, opacity: 0.3))))
                            .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
                    }
                    
                    VStack(alignment: .leading,spacing: 12){
                        Text("Password")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .font(.footnote)
                        
                        TextField("Enter Your password", text: $password)
                            .foregroundStyle(.white)
                         
                        
                        Rectangle()
                            .foregroundStyle(Color(.init(Color(white: 1, opacity: 0.3))))
                            .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
                    }
                    
                    
                    
                }
                .padding(.top,12)
                .padding(.horizontal)
                    
                
              
                
                
                VStack{
                    
                    HStack{
                        Rectangle()
                            .frame(width: 76, height: 1)
                            .foregroundStyle(.white)
                            .opacity(0.7)
                        
                        Text("Sign in with Social")
                            .foregroundStyle(.white)
                            .opacity(0.7)
                            .fontWeight(.semibold)
                        
                        
                        Rectangle()
                            .frame(width: 76, height: 1)
                            .foregroundStyle(.white)
                            .opacity(0.7)
                        
                    }
                    
                    HStack(spacing: 30){
                        
                        Button {
                            
                        } label: {
                            Image(.facebook)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44)
                        }

                        Button {
                            
                        } label: {
                            Image(.google)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44)
                        }

                        
                    }
                    
                    
                    Button {
                        
                    } label: {
                        HStack{
                            Text("SIGN IN")
                                .foregroundStyle(.black)
                               
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.black)
                                
                        }
                        .frame(width: UIScreen.main.bounds.width - 32,height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                        )
                    }
                    .padding()
                    
                }
                .padding(.vertical)
                
                HStack{
                    
                    Button {
                        
                    } label: {
                        Text("Don't have an account?")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .semibold))
                            
                        
                        Text("Sign up")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .semibold))
                    }

                }


                    
            }
        }
    }
}

#Preview {
    LoginView()
}
