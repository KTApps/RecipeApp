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
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    func threadCheck(in section: String) {
        if Thread.isMainThread {
            print("\(section) Main Thread")
        } else {
            let thread = Thread.current.description
            print("\(section) Thread: \(thread)")
        }
    }
    
    func updateFirestoreRecipes(with title: String, ingredients: String, instructions: String, calories: String, category: String) async throws {
        
        threadCheck(in: "start of updateFirestoreRecipes")
        
        let recipeModel = RecipeModel(title: title,
                                      ingredients: ingredients,
                                      instructions: instructions,
                                      calories: calories,
                                      category: category)
        
        DispatchQueue.main.async {
            
            self.threadCheck(in: "updating recipeList")
            
            for recipe in self.authViewModel.recipeList {
                if title == recipe.title {
                    print("func updateFirestoreRecipes(): recipe already exists")
                    break
                }
            }
            self.authViewModel.recipeList.append(recipeModel)
        }
        
        threadCheck(in: "after updating recipeList")
        
        guard let userId = authViewModel.currentUser?.id else {
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
            
            threadCheck(in: "after updateFirestoreRecipes")
            
        } catch {
            throw error
        }
    }
}
