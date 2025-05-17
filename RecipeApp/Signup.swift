//
//  Signup.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Signup: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                TextFieldTemplate(
                    text: $username,
                    title: "Username",
                    placeholder: "Enter username")
                
                Spacer()
                    .frame(height: 30)
                
                TextFieldTemplate(
                    text: $email,
                    title: "Email",
                    placeholder: "Enter email")
                
                Spacer()
                    .frame(height: 30)
                
                TextFieldTemplate(
                    text: $password,
                    title: "Password",
                    placeholder: "Enter password")
                
                Spacer()
                    .frame(height: 100)
                
                Button {
                    Task {
                        try await authViewModel.signUp(withEmail: email,
                                                        username: username,
                                                        password: password)
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .frame(width: 300, height: 60)
                            .foregroundColor(.blue)
                        Text("Sign Up")
                            .font(.system(size: 25))
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                    .frame(height: 100)
                
                NavigationLink {
                    Login()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Click here to Log In")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                .padding(.bottom, 20)
                
            }
            .padding()
        }
    }
}

#Preview {
    Signup()
}
