//
//  AuthenticationTemplate.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct AuthenticationTemplate: View {
    @Binding var username: String
    @Binding var password: String
    var buttonString: String
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 200)
                
                TextFieldTemplate(
                    text: $username,
                    title: "username",
                    placeholder: "Enter username")
                
                Spacer()
                    .frame(height: 40)
                
                TextFieldTemplate(
                    text: $password,
                    title: "password",
                    placeholder: "Enter password")
                
                Spacer()
                    .frame(height: 60)
                
                NavigationLink {
                    Lobby()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    ZStack {
                        Capsule()
                            .frame(width: 300, height: 60)
                            .foregroundColor(.blue)
                        Text(buttonString)
                            .font(.system(size: 25))
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                    .frame(height: 230)
                
                if buttonString == "Log In" {
                    NavigationLink {
                        Signup()
                    } label: {
                        ZStack {
                            Text("Click here to Sign Up")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    AuthenticationTemplate(username: .constant("username"), password: .constant("password"), buttonString: "Log In")
}
