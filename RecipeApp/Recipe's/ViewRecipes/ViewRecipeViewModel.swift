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
        guard let userId = currentUser?.id else {
            print("func retrieveRecipeList(): user not logged in")
            return
        }
        let userRef = databaseRef.collection("users").document(userId)
        do {
            let recipeListSnapshot = try await userRef.collection("Recipes").getDocuments()
            guard !recipeListSnapshot.isEmpty else {
                print("func retrieveRecipeList(): No recipes")
                return
            }
            for recipe in recipeListSnapshot.documents {
                let recipeData = recipe.data()
                let decodedRecipe = try Firestore.Decoder().decode(RecipeModel.self, from: recipeData)
                recipeList.append(decodedRecipe)
            }
        } catch {
            throw error
        }
    }
}
