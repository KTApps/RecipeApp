//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 18/05/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RecipeViewModel {
    let authViewModel: AuthViewModel
    let recipeState: RecipeState
    init(authViewModel: AuthViewModel, recipeState: RecipeState) {
        self.authViewModel = authViewModel
        self.recipeState = recipeState
    }
    
    func updateFirestoreRecipes(with title: String, ingredients: String, instructions: String, calories: String) async throws {
        
        let recipeModel = RecipeModel(title: title,
                                      ingredients: ingredients,
                                      instructions: instructions,
                                      calories: calories)
        
        DispatchQueue.main.async {
            for recipe in self.recipeState.recipeList {
                if title == recipe.title {
                    print("func updateFirestoreRecipes(): recipe already exists")
                    break
                }
            }
            self.recipeState.recipeList.append(recipeModel)
        }
        
        guard let userId = await authViewModel.currentUser?.id else {
            print("updateFirestoreRecipes(): user not logged in")
            return
        }
        let userRef = authViewModel.databaseRef.collection("users").document(userId)
        let userRecipesRef = userRef.collection("Recipes").document(title)
        do {
            let recipeDoc = try await userRecipesRef.getDocument()
            guard !recipeDoc.exists else {
                print("Recipe exists")
                return
            }
            let encodedRecipe = try Firestore.Encoder().encode(recipeModel)
            try await userRecipesRef.setData(encodedRecipe)
        } catch {
            throw error
        }
    }
}
