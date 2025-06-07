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
            .sink(receiveValue: { [weak self] (isEmailValid) in
                guard let self = self else { return }
                self.isEmailValid = isEmailValid
            })
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
            .sink(receiveValue: { [weak self] (isPasswordValid) in
                guard let self = self else { return }
                self.isPasswordValid = isPasswordValid
            })
            .store(in: &cancellables)
    }
}
