//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI
import Firebase

@main
struct RecipeAppApp: App {
    
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Lobby(authViewModel: authViewModel)
        }
    }
}
