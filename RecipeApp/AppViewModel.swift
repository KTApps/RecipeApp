//
//  AppViewModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 13/05/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AppViewModel {
    let authRef = Auth.auth()
    let databaseRef = Firestore.firestore()
    let userSession: FirebaseAuth.User? = nil
    let currentUser: AuthModel? = nil
}

protocol AuthViewModel {
    var userSession: FirebaseAuth.User? { get }
    var currentUser: AuthModel? { get }
    
    func signUp(withEmail email: String, username: String, password: String) async throws
    func logIn(withUsername username: String, password: String) async throws
}
