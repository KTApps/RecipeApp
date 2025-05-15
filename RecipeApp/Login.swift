//
//  Login.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Login: View {
    @StateObject var authViewModel: AuthViewModel
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 200)
                
                TextFieldTemplate(
                    text: $username,
                    title: "Username",
                    placeholder: "Enter username")
                
                Spacer()
                    .frame(height: 60)
                
                TextFieldTemplate(
                    text: $password,
                    title: "Password",
                    placeholder: "Enter password")
                
                Spacer()
                    .frame(height: 60)
                
                NavigationLink {
                    Lobby(authViewModel: authViewModel)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    ZStack {
                        Capsule()
                            .frame(width: 300, height: 60)
                            .foregroundColor(.blue)
                        Text("Log In")
                            .font(.system(size: 25))
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                    .frame(height: 200)
                
                NavigationLink {
                    Signup(authViewModel: authViewModel)
                } label: {
                    ZStack {
                        Text("Click here to Sign Up")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    Login(authViewModel: AuthViewModel())
}
