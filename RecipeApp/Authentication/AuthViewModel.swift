//
//  AuthViewModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 05/06/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class AuthViewModel: ObservableObject {
    let authState: AuthState
    init(authState: AuthState) {
        self.authState = authState
    }
    
    @Published var textFieldPassword: String = ""
    @Published var isPasswordValid: Bool = false
    
    func passwordChecker() {
        $textFieldPassword
            .map { (text) -> Bool in
                if text.count >= 6 {
                    return true
                }
                return false
            }
            .assign(to: &isPasswordValid)
    }
}
