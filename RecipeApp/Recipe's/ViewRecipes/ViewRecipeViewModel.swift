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

extension RecipeState: ViewRecipeViewModel {
    func retrieveRecipeList() async throws {
        guard let userId = authViewModel.currentUser?.id else {
            print("func retrieveRecipeList(): user not logged in")
            return
        }
        let userRef = authViewModel.databaseRef.collection("users").document(userId)
        do {
            let recipeListSnapshot = try await userRef.collection("Recipes").getDocuments()
            guard !recipeListSnapshot.isEmpty else {
                print("func retrieveRecipeList(): No recipes")
                return
            }
            for recipe in recipeListSnapshot.documents {
                let decodedRecipe = try Firestore.Decoder().decode(RecipeModel.self, from: recipe)
                recipeList.append(decodedRecipe)
            }
        } catch {
            throw error
        }
    }
}
