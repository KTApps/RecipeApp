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

@MainActor
class RecipeListViewModel: ObservableObject {
    let authViewModel: AuthViewModel
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    @Published var recipeList: [RecipeModel] = []
    
    let decoder = Firestore.Decoder()
    
    func retrieveRecipeList() async throws {
        let userId = authViewModel.currentUser?.id
        let userRef = authViewModel.databaseRef.collection("users").document(userId!)
        let recipeDocs = try await userRef.collection("Recipes").getDocuments()
        guard !recipeDocs.isEmpty else {
            print("func retrieveRecipeList(): no recipes")
            return
        }
        for recipe in recipeDocs.documents {
            let decodedRecipe = try decoder.decode(RecipeModel.self, from: recipe)
            recipeList.append(decodedRecipe)
        }
    }
}
