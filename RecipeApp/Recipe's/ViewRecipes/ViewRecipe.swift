//
//  ViewRecipe.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct ViewRecipe: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(authViewModel.recipeList.indices, id: \.self) { index in
                    let recipe = authViewModel.recipeList[index]
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
    ViewRecipe(authViewModel: AuthViewModel())
}
