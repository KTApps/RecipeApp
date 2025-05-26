//
//  UnitTesting_practice_Tests.swift
//  RecipeAppTests
//
//  Created by Kelvin Mahaja on 25/05/2025.
//

import XCTest
@testable import RecipeApp

// Naming Structure: test_[struct or class]_[variable or function]_[expected value]
// Testing Structure: Given, When, Then

final class UnitTesting_practice_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UnitTesting_practice_viewModel_isPremium_shouldBeTrue() {
        for _ in 0..<10 {
            // Given
            let isPremium: Bool = Bool.random()
            
            // When
            let viewModel = UnitTesting_practice_viewModel(isPremium: isPremium)
            
            // Then
            XCTAssertEqual(isPremium, viewModel.isPremium)
        }
    }
    
    func test_UnitTesting_practice_viewModel_appendArray_shouldAppend() {
        // Given
        let viewModel = UnitTesting_practice_viewModel(isPremium: Bool.random())
        
        // When
        let maxItems: Int = Int.random(in: 0..<100)
        for _ in 0..<maxItems {
            viewModel.appendArray(with: UUID().uuidString)
        }
        
        // Then
        XCTAssertEqual(viewModel.dataArray.count, maxItems)
    }
    
    func test_UnitTesting_practice_viewModel_appendArray_shouldntAppendEmptyItems() {
        // Given
        let viewModel = UnitTesting_practice_viewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        for _ in 0..<loopCount {
            viewModel.appendArray(with: "")
        }
        
        // Then
        XCTAssertEqual(viewModel.dataArray.count, 0)
    }
    
    func test_UnitTesting_practice_viewModel_selectItem_shouldStartAsNil() {
        // Given
        
        // When
        let viewModel = UnitTesting_practice_viewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTesting_practice_viewModel_selectedItem_shouldbeNilWhenItemNotFound() {
        // Given
        let viewModel = UnitTesting_practice_viewModel(isPremium: Bool.random())
        
        // When
        let maxItems: Int = Int.random(in: 0..<10)
        for _ in 0..<maxItems {
            viewModel.selectItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTesting_practice_viewModel_selectedItem_shouldEqualItem() {
        // Given
        let viewModel = UnitTesting_practice_viewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<10)
        var localArray: [String] = []
        
        for _ in 0..<loopCount {
            let string = UUID().uuidString
            viewModel.appendArray(with: string)
            localArray.append(string)
        }
        
        let randomItem = localArray.randomElement() ?? ""
        viewModel.selectItem(item: randomItem)
        
        // Then
        XCTAssertEqual(viewModel.selectedItem, randomItem)
    }
    
    func test_UnitTesting_practice_viewModel_selectedItem_shouldReturnToNilWhenNewItemIsntFound() {
        // Given
        let viewModel = UnitTesting_practice_viewModel(isPremium: Bool.random())
        
        // When
        let string = UUID().uuidString
        viewModel.appendArray(with: string)
        viewModel.selectItem(item: string)
        
        viewModel.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertEqual(viewModel.selectedItem, nil)
    }
}
