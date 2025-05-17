//
//  AuthViewModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 13/05/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    let authRef = Auth.auth()
    let databaseRef = Firestore.firestore()
    var userSession: FirebaseAuth.User? = nil // user in the backend
    @Published var currentUser: AuthModel? = nil // user in memory (frontend)
    
    @Published var userExists: Bool = false
    
    func signUp(withEmail email: String, username: String, password: String) async throws {
        do {
            /// Checks if user already has an existing document
            let userDocSnapshot = try await databaseRef.collection("users")
                .whereField("AuthenticationData.email", isEqualTo: email)
                .getDocuments()
            
            /// Return if user already exists
            guard userDocSnapshot.isEmpty else {
                print("user exists")
                userExists = true
                return
            }
            
            /// Create user in Firebase Authentication
            let user = try await authRef.createUser(withEmail: email, password: password)
            userSession = user.user
            
            /// Create instance of user in memory
            let userModel = AuthModel(id: user.user.uid, email: email, username: username)
            currentUser = userModel
            
            /// Add user into Firestore Database in JSON format
            let encodedUser = try Firestore.Encoder().encode(userModel)
            let userDocRef = databaseRef.collection("users").document(userModel.id)
            try await userDocRef.setData([
                "AuthenticationData" : encodedUser
            ])
            
        } catch {
            throw error
        }
    }
}
