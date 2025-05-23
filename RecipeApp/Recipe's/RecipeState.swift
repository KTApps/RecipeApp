//
//  RecipeState.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 23/05/2025.
//

import Foundation

protocol ViewRecipeViewModel {
    func retrieveRecipeList() async throws
}

protocol ViewRecipeBookViewModel {
    func retrieveRecipeBookList() async throws
}
