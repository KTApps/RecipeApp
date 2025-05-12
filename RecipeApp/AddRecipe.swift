//
//  ContentView.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct AddRecipe: View {
    
    @State var recipeTitle: String = ""
    @State var ingredients: String = ""
    @State var instructions: String = ""
    @State var calories: String = ""
    
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
        }
        .padding()
    }
}

#Preview {
    AddRecipe()
}
