//
//  Signup.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Signup: View {
    @StateObject var authViewModel = AuthViewModel()
    @ObservedObject var authState: AuthState
    @State var username: String = ""
    
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
                    text: $authViewModel.textFieldEmail,
                    title: "Email",
                    placeholder: "Enter email")
                
                Spacer()
                    .frame(height: 30)
                
                TextFieldTemplate(
                    text: $authViewModel.textFieldPassword,
                    title: "Password",
                    placeholder: "Enter password")
                
                Spacer()
                    .frame(height: 100)
                
                Button {
                    if authViewModel.isPasswordValid && authViewModel.isEmailValid {
                        Task {
                            try await authState.signUp(withEmail: authViewModel.textFieldEmail,
                                                       username: username,
                                                       password: authViewModel.textFieldPassword)
                        }
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
                    .opacity(authViewModel.isPasswordValid && authViewModel.isEmailValid ? 1 : 0.5)
                }
                
                Spacer()
                    .frame(height: 100)
                
                NavigationLink {
                    Login(authState: authState)
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
    Signup(authState: AuthState())
}
