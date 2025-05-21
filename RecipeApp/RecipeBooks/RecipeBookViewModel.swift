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
    let authViewModel: AuthViewModel
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    func updateRecipeBooks(with book: String, recipe: [String]) async throws {
        
        /// update local memory with new recipe book
        let recipeBook = RecipeBookModel(bookTitle: book,
                                         recipeTitles: recipe)
        
        /// add recipe book to recipe book list in the main thread for a quick display
        DispatchQueue.main.async {
            for recBook in self.authViewModel.recipeBookList {
                if recBook.bookTitle == book {
                    print("func updateFirestoreRecipeBooks(): book already exists")
                    break
                }
            }
            self.authViewModel.recipeBookList.append(recipeBook)
        }
        
        /// add recipe book to recipe book list on firestore in the background thread
        
    }
}
