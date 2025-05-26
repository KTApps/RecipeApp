//
//  UnitTesting_practice_view.swift
//  RecipeApp
//
//  Created by Kelvin Mahaja on 25/05/2025.
//

import SwiftUI

class UnitTesting_practice_viewModel: ObservableObject {
    @Published var isPremium: Bool
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    @Published var dataArray: [String] = []
    func appendArray(with item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    @Published var selectedItem: String? = nil
    func selectItem(item: String) {
        if let foundItem = self.dataArray.first(where: { $0 == item }) {
            self.selectedItem = foundItem
        } else {
            self.selectedItem = nil
        }
    }
}

struct UnitTesting_practice_view: View {
    @StateObject var viewModel: UnitTesting_practice_viewModel
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: UnitTesting_practice_viewModel(isPremium: isPremium))
    }
    var body: some View {
        Text(viewModel.isPremium.description)
    }
}

#Preview {
    UnitTesting_practice_view(isPremium: true)
}
