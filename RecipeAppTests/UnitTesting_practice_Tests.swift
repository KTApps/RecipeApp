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

    var vm: UnitTesting_practice_viewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        vm = UnitTesting_practice_viewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        vm = nil
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
        guard let viewModel = vm else {
            XCTFail()
            return
        }
        
        // When
        let maxItems: Int = Int.random(in: 5..<100)
        for _ in 0..<maxItems {
            viewModel.appendArray(with: UUID().uuidString)
        }
        
        // Then
        XCTAssertEqual(viewModel.dataArray.count, maxItems)
    }
    
    func test_UnitTesting_practice_viewModel_appendArray_shouldntAppendEmptyItems() {
        // Given
        guard let viewModel = vm else {
            XCTFail()
            return
        }
        
        // When
        let loopCount: Int = Int.random(in: 5..<100)
        for _ in 0..<loopCount {
            viewModel.appendArray(with: "")
        }
        
        // Then
        XCTAssertEqual(viewModel.dataArray.count, 0)
    }
    
    func test_UnitTesting_practice_viewModel_selectItem_shouldStartAsNil() {
        // Given
        guard let viewModel = vm else {
            XCTFail()
            return
        }
        
        // When
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTesting_practice_viewModel_selectedItem_shouldbeNilWhenItemNotFound() {
        // Given
        guard let viewModel = vm else {
            XCTFail()
            return
        }
        
        // When
        let maxItems: Int = Int.random(in: 5..<10)
        for _ in 0..<maxItems {
            viewModel.selectItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTesting_practice_viewModel_selectedItem_shouldEqualItem() {
        // Given
        guard let viewModel = vm else {
            XCTFail()
            return
        }
        
        // When
        let loopCount: Int = Int.random(in: 5..<10)
        var localArray: [String] = []
        
        for _ in 0..<loopCount {
            let string = UUID().uuidString
            viewModel.appendArray(with: string)
            localArray.append(string)
        }
        
        let randomItem = localArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        viewModel.selectItem(item: randomItem)
        
        // Then
        XCTAssertEqual(viewModel.selectedItem, randomItem)
    }
    
    func test_UnitTesting_practice_viewModel_selectedItem_shouldReturnToNilWhenNewItemIsntFound() {
        // Given
        guard let viewModel = vm else {
            XCTFail()
            return
        }
        
        // When
        let string = UUID().uuidString
        viewModel.appendArray(with: string)
        viewModel.selectItem(item: string)
        
        viewModel.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertEqual(viewModel.selectedItem, nil)
    }
    
    func test_UnitTesting_practice_viewModel_saveItem_shouldThrowDataError_noData() {
        // Given
        guard let viewModel = vm else {
            XCTFail()
            return
        }
        
        // When
        let loopCount = Int.random(in: 5..<10)
        for _ in 0..<loopCount {
            viewModel.appendArray(with: UUID().uuidString)
        }
        
        // Then
        do {
            try viewModel.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTesting_practice_viewModel.DataError
            XCTAssertEqual(returnedError, UnitTesting_practice_viewModel.DataError.noData)
        }
    }
    
    func test_UnitTesting_practice_viewModel_saveItem_shouldThrowDataError_itemNotFound() {
        // Given
        guard let viewModel = vm else {
            XCTFail()
            return
        }
        
        // When
        let loopCount = Int.random(in: 5..<10)
        for _ in 0..<loopCount {
            viewModel.appendArray(with: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try viewModel.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try viewModel.saveItem(item: UUID().uuidString), "Should throw itemNotFound error", { error in
            let returnedError = error as? UnitTesting_practice_viewModel.DataError
            XCTAssertEqual(returnedError, UnitTesting_practice_viewModel.DataError.itemNotFound)
        })
    }
    
    func test_UnitTesting_practice_viewModel_saveItem_shouldSaveItem() {
        // Given
        guard let viewModel = vm else {
            XCTFail()
            return
        }
        
        // When
        let loopCount = Int.random(in: 5..<10)
        var itemArray: [String] = []
        
        for _ in 0..<loopCount {
            let string = UUID().uuidString
            viewModel.appendArray(with: string)
            itemArray.append(string)
        }
        
        let randomItem = itemArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        // Then
        XCTAssertNoThrow(try viewModel.saveItem(item: randomItem))
    }
}
