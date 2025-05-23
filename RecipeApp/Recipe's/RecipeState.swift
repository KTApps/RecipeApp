//
//  RecipeState.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 23/05/2025.
//

import Foundation

@MainActor
class RecipeState: ObservableObject {
    
    let authViewModel: AuthViewModel
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    @Published var recipeList: [RecipeModel] = []
    @Published var recipeBookList: [RecipeBookModel] = []
}

protocol ViewRecipeViewModel {
    func retrieveRecipeList() async throws
}

protocol ViewRecipeBookViewModel {
    func retrieveRecipeBookList() async throws
}
