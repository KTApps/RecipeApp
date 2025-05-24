//
//  Login.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Login: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
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
                        try await authViewModel.logIn(withEmail: email, 
                                                      password: password)
                        
                        email = ""
                        password = ""
                    }
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
                    .frame(height: 100)
                
                NavigationLink {
                    Signup(authViewModel: authViewModel)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Click here to Sign Up")
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
    Login(authViewModel: AuthViewModel())
}
