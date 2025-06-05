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
    
    @StateObject var authState = AuthState()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Lobby(authState: authState)
        }
    }
}
