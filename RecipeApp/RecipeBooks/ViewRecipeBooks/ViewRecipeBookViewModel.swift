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

protocol ViewRecipeBookViewModel {
    func retrieveRecipeBookList() async throws
}

extension AuthState: ViewRecipeBookViewModel {
    func retrieveRecipeBookList() async throws {
        
        threadCheck(in: "Start of ViewRecipeBookViewModel")
        
        /// check if user is logged in
        guard let userId = currentUser?.id else {
            print("func retrieveRecipeBookList(): user not logged in")
            return
        }
        
        /// reference the database
        let userRef = databaseRef.collection("users").document(userId)
        do {
            let recipeBooksSnapshot = try await userRef.collection("RecipeBooks").getDocuments()
            guard !recipeBooksSnapshot.isEmpty else {
                print("func retrieveRecipeBookList(): no books")
                return
            }
            
            /// transfer recipe books to memory for faster performance
            for recBook in recipeBooksSnapshot.documents {
                let recBookData = recBook
                let decodedRecBook = try Firestore.Decoder().decode(RecipeBookModel.self, from: recBookData)
                DispatchQueue.main.async {
                    
                    self.threadCheck(in: "updating recipeBookList")
                    
                    self.recipeBookList.append(decodedRecBook)
                }
            }
            
            threadCheck(in: "after ViewRecipeBookViewModel")
            
        } catch {
            throw error
        }
    }
    
}
