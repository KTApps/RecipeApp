//
//  TabView.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Lobby: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                TabView {
                    ViewRecipe(authViewModel: authViewModel)
                        .tabItem {
                            Image(systemName: "fork.knife")
                        }
                    
                    AddRecipe(recipeViewModel: RecipeViewModel(authViewModel: authViewModel))
                        .tabItem {
                            Image(systemName: "plus")
                        }
                    
                    RecipeBooks()
                        .tabItem {
                            Image(systemName: "book")
                        }
                }
            } else {
                Login(authViewModel: authViewModel)
            }
        }
    }
}

#Preview {
    Lobby(authViewModel: AuthViewModel())
}
