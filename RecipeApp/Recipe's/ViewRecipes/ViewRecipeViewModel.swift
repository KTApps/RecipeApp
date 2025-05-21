//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 18/05/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

extension AuthViewModel: ViewRecipeViewModel {
    func retrieveRecipeList() async throws {
        let userId = currentUser?.id
        let userRef = databaseRef.collection("users").document(userId!)
        let recipeListSnapshot = try await userRef.collection("Recipes").getDocuments()
        guard !recipeListSnapshot.isEmpty else {
            print("func retrieveRecipeList(): No recipes")
            return
        }
        for recipe in recipeListSnapshot.documents {
            let decodedRecipe = try decoder.decode(RecipeModel.self, from: recipe)
            self.recipeList.append(decodedRecipe)
        }
    }
}
