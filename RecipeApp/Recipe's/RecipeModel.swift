//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 18/05/2025.
//

import SwiftUI

struct RecipeModel: Codable {
    let title: String
    let ingredients: String
    let instructions: String
    let calories: String
    let category: String
}

enum mealCategory: String, CaseIterable {
    case breakfast
    case lunch
    case snack
    case dinner
    case desert
}
