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

protocol AuthStateExtension {
    var userSession: FirebaseAuth.User? { get }
    var currentUser: AuthModel? { get }
    
    func signUp(withEmail email: String, username: String, password: String) async throws
    func logIn(withEmail email: String, password: String) async throws
}

extension AuthState: AuthStateExtension {
    
    func signUp(withEmail email: String, username: String, password: String) async throws {
        do {
            
            threadCheck(in: "Start of sign up")
            
            /// Checks if user already has an existing document
            let userDocSnapshot = try await databaseRef.collection("users")
                .whereField("AuthenticationData.email", isEqualTo: email)
                .getDocuments()
            
            /// Return if user already exists
            guard userDocSnapshot.isEmpty else {
                print("user exists")
                DispatchQueue.main.async {
                    
                    self.threadCheck(in: "updating userExists")
                    
                    self.userExists = true
                }
                return
            }
            
            /// Create user in Firebase Authentication
            let user = try await authRef.createUser(withEmail: email, password: password)
            userSession = user.user
            
            /// Create instance of user in memory
            let userModel = AuthModel(id: user.user.uid, email: email, username: username)
            DispatchQueue.main.async {
                
                self.threadCheck(in: "updating currentUser")
                
                self.currentUser = userModel
            }
            
            /// Add user into Firestore Database in JSON format
            let encodedUser = try Firestore.Encoder().encode(userModel)
            let userDocRef = databaseRef.collection("users").document(user.user.uid)
            try await userDocRef.setData([
                "AuthenticationData" : encodedUser
            ])
            
            threadCheck(in: "after sign up")
            
        } catch {
            throw error
        }
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do {
            
            threadCheck(in: "Start of logIn")
            
            let user = try await authRef.signIn(withEmail: email, password: password)
            userSession = user.user
            
            let userRef = databaseRef.collection("users").document(user.user.uid)
            let doc = try await userRef.getDocument()
            guard doc.exists else {
                print("func logIn(): User doc doesnt exist")
                return
            }
            if let data = doc.data(),
               let authData = data["AuthenticationData"] as? [String: Any] {
                let username = authData["username"] as? String
                let userModel = AuthModel(id: user.user.uid, email: email, username: username ?? "")
                DispatchQueue.main.async {
                    
                    self.threadCheck(in: "updating currentUser")
                    
                    self.currentUser = userModel
                }
            } else {
                print("func logIn(): AuthData doesnt exist")
            }
            
            try await retrieveRecipeList()
            
            threadCheck(in: "after logIn")
            
        } catch {
            throw error
        }
    }
    
}
