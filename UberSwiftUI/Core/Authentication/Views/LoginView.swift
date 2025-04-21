//
//  LoginView.swift
//  UberSwiftUI
//
//  Created by Nitin on 17/04/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var email: String = ""
    @State var password: String = ""
    
    
    var body: some View {
        NavigationStack {
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
                        CustomInputField(text: $email, title: "Email Address", placeholder: "Enter Your Email")
                        
                        CustomInputField(text: $password, title: "Password", placeholder: "Enter Your Password" , isSecureField: true)
                        
                        HStack{
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Forgot Password?")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                        }
                        
                        
                    }
                    .padding(.top,12)
                    .padding(.horizontal)
                    
                    
                    // Social Sign in
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
                            viewModel.signIn(withEmail: email, password: password)
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
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack{
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
}

#Preview {
    LoginView()
}
