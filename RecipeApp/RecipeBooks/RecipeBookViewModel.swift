//
//  RecipeBookViewModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 21/05/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RecipeBookViewModel {
    let recipeState: RecipeState
    let authViewModel: AuthViewModel
    init(authViewModel: AuthViewModel, recipeState: RecipeState) {
        self.authViewModel = authViewModel
        self.recipeState = recipeState
    }
    
    func updateRecipeBooks(with book: String, recipe: [String]) async throws {
        
        /// update local memory with new recipe book
        let recipeBook = RecipeBookModel(bookTitle: book,
                                         recipeTitles: recipe)
        
        /// add recipe book to recipe book list in the main thread for a quick display
        DispatchQueue.main.async {
            for recBook in self.recipeState.recipeBookList {
                if recBook.bookTitle == book {
                    print("func updateFirestoreRecipeBooks(): book already exists")
                    break
                }
            }
            self.recipeState.recipeBookList.append(recipeBook)
        }
        
        /// add recipe book to recipe book list on firestore in the background thread
        guard let userId = await authViewModel.currentUser?.id else {
            print("func updateRecipeBooks(): User's not logged in")
            return
        }
        
        let userRef = authViewModel.databaseRef.collection("users").document(userId)
        let recipeBookRef = userRef.collection("RecipeBooks").document(book)
        do {
            let bookSnapshot = try await recipeBookRef.getDocument()
            guard !bookSnapshot.exists else {
                print("func updateRecipeBooks(): book already exists")
                return
            }
            let encodedBook = try Firestore.Encoder().encode(recipeBook)
            try await recipeBookRef.setData(encodedBook)
        } catch {
            throw error
        }
    }
}
