//
//  RegistrationView.swift
//  UberSwiftUI
//
//  Created by Nitin on 17/04/25.
//

import SwiftUI

struct RegistrationView: View {
    @State var name : String = ""
    @State var email : String = ""
    @State var password : String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {

        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading,spacing: 20){
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .foregroundColor(.white)
                        .padding()
                }
                
                
                Text("Create New Account")
                    .foregroundStyle(.white)
                    .font(.system(size: 40, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                
                Spacer()
                
                
                VStack{
                    VStack(spacing: 56){
                        CustomInputField(text: $name, title: "Full Name", placeholder: "Enter your name")
                        CustomInputField(text: $email, title: "Email Address", placeholder: "Enter your email")
                        CustomInputField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        HStack{
                            Text("SIGN UP")
                                .foregroundStyle(.black)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                        )
                    }
                    
                    Spacer()
                    
                }
                
                
            }
            .padding(.horizontal, 24)
            
            
            
        }
    }
}


#Preview {
    RegistrationView()
}
