//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 18/05/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RecipeViewModel {
    let authViewModel: AuthViewModel
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    func updateFirestoreRecipes(with title: String, ingredients: String, instructions: String, calories: String) async throws {
        let userId = await authViewModel.currentUser?.id
        let userRef = authViewModel.databaseRef.collection("users").document(userId!)
        let userRecipesRef = userRef.collection("Recipes").document(title)
        do {
            let recipeDoc = try await userRecipesRef.getDocument()
            guard !recipeDoc.exists else {
                print("Recipe exists")
                return
            }
            let recipeModel = RecipeModel(title: title,
                                          ingredients: ingredients,
                                          instructions: instructions,
                                          calories: calories)
            let encodedRecipe = try authViewModel.encoder.encode(recipeModel)
            try await userRecipesRef.setData(encodedRecipe)
        } catch {
            throw error
        }
    }
}
