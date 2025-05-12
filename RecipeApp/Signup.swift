//
//  Signup.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Signup: View {
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        AuthenticationTemplate(
            username: $username,
            password: $password,
            buttonString: "Sign Up")
    }
}

#Preview {
    Signup()
}
