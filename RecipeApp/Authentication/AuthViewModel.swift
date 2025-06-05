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
    
    @Published var textFieldPassword: String = ""
    @Published var isPasswordValid: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        passwordChecker()
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
}
