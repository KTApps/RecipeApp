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

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var textFieldEmail: String = ""
    @Published var isEmailValid: Bool = false
    
    @Published var textFieldPassword: String = ""
    @Published var isPasswordValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        emailChecker()
        passwordChecker()
    }
    
    func emailChecker() {
        $textFieldEmail
            .map { (text) -> Bool in
                if text.contains("@") {
                    return true
                }
                return false
            }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)
    }
    
    func passwordChecker() {
        $textFieldPassword
            .map { (text) -> Bool in
                if text.count >= 6 {
                    return true
                }
                return false
            }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellables)
    }
    
    func cancelSubscriptions() {
        cancellables.removeAll()
    }
}
