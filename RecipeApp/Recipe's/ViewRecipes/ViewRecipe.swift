//
//  ViewRecipe.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct ViewRecipe: View {
    @ObservedObject var authState: AuthState
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(authState.recipeList.indices, id: \.self) { index in
                    let recipe = authState.recipeList[index]
                    NavigationLink {
                        RecipeView()
                    } label: {
                        VStack {
                            Text(recipe.title)
                            Text(recipe.calories)
                        }
                    }
                }
            }
        }
    }
}

struct RecipeView: View {
    var body: some View {
        Text("")
    }
}

#Preview {
    ViewRecipe(authState: AuthState())
}
