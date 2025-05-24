//
//  ContentView.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct AddRecipe: View {
    
    let recipeViewModel: RecipeViewModel
    
    @State var recipeTitle: String = ""
    @State var ingredients: String = ""
    @State var instructions: String = ""
    @State var calories: String = ""
    
    @State var category: mealCategory = .breakfast
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 40)
            
            TextFieldTemplate(
                text: $recipeTitle,
                title: "Title",
                placeholder: "Enter name of recipe")
            
            Spacer()
                .frame(height: 40)
            
            TextFieldTemplate(
                text: $ingredients,
                title: "Ingredients",
                placeholder: "Enter Ingredients")
            
            Spacer()
                .frame(height: 40)
            
            TextFieldTemplate(
                text: $instructions,
                title: "Instructions",
                placeholder: "Enter Instructions")
            
            Spacer()
                .frame(height: 40)
            
            TextFieldTemplate(
                text: $calories,
                title: "calories",
                placeholder: "Enter calories")
            
            Spacer()
                .frame(height: 60)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(mealCategory.allCases, id: \.self) { meal in
                        Button {
                            category = meal
                        } label: {
                            ZStack {
                                Capsule()
                                    .frame(width: 80, height: 30)
                                    .foregroundColor(meal == category ? .blue : .gray)
                                Text("\(meal)")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            Button {
                if recipeTitle != "" {
                    Task {
                        try await recipeViewModel.updateFirestoreRecipes(with: recipeTitle,
                                                                         ingredients: ingredients,
                                                                         instructions: instructions,
                                                                         calories: calories,
                                                                         category: category.rawValue)
                        recipeTitle = ""
                        ingredients = ""
                        instructions = ""
                        calories = ""
                    }
                }
            } label: {
                ZStack {
                    Capsule()
                        .frame(width: 300, height: 60)
                    Text("Add Recipe")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddRecipe(recipeViewModel: RecipeViewModel(authViewModel: AuthViewModel()))
}
