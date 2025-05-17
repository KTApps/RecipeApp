//
//  TabView.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Lobby: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        Group {
            if authViewModel.currentUser != nil {
                TabView {
                    ViewRecipe()
                        .tabItem {
                            Image(systemName: "fork.knife")
                        }
                    
                    AddRecipe()
                        .tabItem {
                            Image(systemName: "plus")
                        }
                    
                    RecipeBooks()
                        .tabItem {
                            Image(systemName: "book")
                        }
                }
            } else {
                Login()
            }
        }
    }
}

#Preview {
    Lobby()
}
