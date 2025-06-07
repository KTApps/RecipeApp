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
    
    func threadCheck(in section: String) {
        if Thread.isMainThread {
            print("\(section): Main Thread")
        } else {
            let thread = Thread.current.description
            print("\(section) Thread: \(thread)")
        }
    }
    
    func updateRecipeBooks(with book: String, recipe: [String]) async throws {
        
        threadCheck(in: "Start of updateRecipeBooks")
        
        /// update local memory with new recipe book
        let recipeBook = RecipeBookModel(bookTitle: book,
                                         recipeTitles: recipe)
        
        /// add recipe book to recipe book list in the main thread for a quick display
        await MainActor.run {
            
            threadCheck(in: "updating recipeBookList")
            
            for recBook in authViewModel.recipeBookList {
                if recBook.bookTitle == book {
                    print("func updateFirestoreRecipeBooks(): book already exists")
                    break
                }
            }
            authViewModel.recipeBookList.append(recipeBook)
        }
        
        threadCheck(in: "after updating recipeBookList")
        
        /// add recipe book to recipe book list on firestore in the background thread
        guard let userId = authViewModel.currentUser?.id else {
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
            
            threadCheck(in: "after RecipeBookViewModel")
            
        } catch {
            throw error
        }
    }
}
