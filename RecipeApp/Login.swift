//
//  Login.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Login: View {
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        AuthenticationTemplate(
            username: $username,
            password: $password,
            buttonString: "Log In")
    }
}

#Preview {
    Login()
}
