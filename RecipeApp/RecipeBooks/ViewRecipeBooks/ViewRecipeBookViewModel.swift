//
//  ViewRecipeBookViewModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 21/05/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

extension RecipeState: ViewRecipeBookViewModel {
    func retrieveRecipeBookList() async throws {
        
        /// check if user is logged in
        guard let userId = authViewModel.currentUser?.id else {
            print("func retrieveRecipeBookList(): user not logged in")
            return
        }
        
        /// reference the database
        let userRef = authViewModel.databaseRef.collection("users").document(userId)
        do {
            let recipeBooksSnapshot = try await userRef.collection("RecipeBooks").getDocuments()
            guard !recipeBooksSnapshot.isEmpty else {
                print("func retrieveRecipeBookList(): no books")
                return
            }
            
            /// transfer recipe books to memory for faster performance
            for recBook in recipeBooksSnapshot.documents {
                let decodedRecBook = try Firestore.Decoder().decode(RecipeBookModel.self, from: recBook)
                recipeBookList.append(decodedRecBook)
            }
        } catch {
            throw error
        }
    }
    
}
