//
//  TabView.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Lobby: View {
    @ObservedObject var authState: AuthState
    var body: some View {
        Group {
            if authState.userSession != nil {
                TabView {
                    ViewRecipe(authState: authState)
                        .tabItem {
                            Image(systemName: "fork.knife")
                        }
                    
                    AddRecipe(recipeViewModel: RecipeViewModel(authState: authState))
                        .tabItem {
                            Image(systemName: "plus")
                        }
                    
                    RecipeBooks()
                        .tabItem {
                            Image(systemName: "book")
                        }
                }
            } else {
                Login(authState: authState)
            }
        }
    }
}

#Preview {
    Lobby(authState: AuthState())
}
