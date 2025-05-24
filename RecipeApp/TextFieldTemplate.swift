//
//  TextFieldTemplate.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 12/05/2025.
//

import SwiftUI

struct TextFieldTemplate: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
            TextField(placeholder, text: $text)
        }
    }
}

#Preview {
    TextFieldTemplate(text: .constant(""), title: "", placeholder: "")
}
