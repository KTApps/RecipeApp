//
//  TabView.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct Lobby: View {
    var body: some View {
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
    }
}

#Preview {
    Lobby()
}
