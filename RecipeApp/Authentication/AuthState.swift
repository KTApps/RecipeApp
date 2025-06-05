//
//  AuthViewModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 13/05/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthState: ObservableObject {
    let authRef = Auth.auth()
    let databaseRef = Firestore.firestore()
    var userSession: FirebaseAuth.User? = nil // user in the backend
    @Published var currentUser: AuthModel? = nil // user in memory (frontend)
    
    @Published var userExists: Bool = false
    
    @Published var recipeList: [RecipeModel] = []
    @Published var recipeBookList: [RecipeBookModel] = []
    
    func threadCheck(in section: String) {
        if Thread.isMainThread {
            print("\(section): Main Thread")
        } else {
            let thread = Thread.current.description
            print("\(section) Thread: \(thread)")
        }
    }
}
