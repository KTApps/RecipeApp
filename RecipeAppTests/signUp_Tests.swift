//
//  signUp_Tests.swift
//  RecipeAppTests
//
//  Created by Kelvin Mahaja on 28/05/2025.
//

import XCTest
@testable import RecipeApp

final class signUp_Tests: XCTestCase {

    var viewModel: AuthViewModel?
    private var mockUserId: String?
    
    /// Create mock details
    let mockEmail = "\(UUID().uuidString)@unitTest.com"
    let mockUsername = UUID().uuidString
    let mockPassword = UUID().uuidString
    
    @MainActor 
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = AuthViewModel()
    }

    @MainActor
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        /// delete user
        if let userId = mockUserId,
           let viewModel = viewModel {
            viewModel.databaseRef.collection("users").document(userId).delete()
            viewModel.authRef.currentUser?.delete()
        }
    }

    @MainActor
    func test_AuthViewModel_signUp_shouldBeAbleToRunWithMultipleSimultaneousAttemps() async throws {
        // Given
        guard let viewModel = viewModel else {
            XCTFail("viewModel not initialised")
            return
        }
        
        // When
        let loopCount = Int.random(in: 5..<10)
        var errors: [Error] = []
        try await withTaskGroup(of: Void.self) { group in
            for _ in  0..<loopCount {
                group.addTask {
                    do {
                        try await viewModel.signUp(withEmail: self.mockEmail, username: self.mockUsername, password: self.mockPassword)
                    } catch {
                        await MainActor.run {
                            errors.append(error)
                        }
                    }
                }
            }
            await group.waitForAll()
        }
        
        // Then
        XCTAssertTrue(errors.isEmpty, "sign up failed with errors: \(errors)")
    }
    
    @MainActor
    func test_AuthViewModel_signUp_userExists_shouldBeTrueifUserExists() async throws {
        // Given
        guard let viewModel = viewModel else {
            XCTFail("ViewModel not initialized")
            return
        }
        
        /// Fail if userExists starts as True
        guard !viewModel.userExists else {
            XCTFail("userExists starts True")
            return
        }
        
        XCTAssertNil(viewModel.userSession)
        
        // When
        /// Add user
        try await viewModel.signUp(withEmail: mockEmail, username: mockUsername, password: mockPassword)
        XCTAssertNotNil(viewModel.userSession)
        self.mockUserId = viewModel.userSession?.uid
        
        /// Try add user again
        try await viewModel.signUp(withEmail: mockEmail, username: mockUsername, password: mockPassword)
        
        // Then
        XCTAssertTrue(viewModel.userExists)
    }
    
    @MainActor
    func test_AuthViewModel_signUp_currentUser_shouldBeProperlySet() async throws {
        // Given
        guard let viewModel = viewModel else {
            XCTFail("viewModel not initialised")
            return
        }
        
        XCTAssertNil(viewModel.userSession)
        XCTAssertNil(viewModel.currentUser)
        
        // When
        try await viewModel.signUp(withEmail: mockEmail, username: mockUsername, password: mockPassword)
        XCTAssertNotNil(viewModel.userSession)
        self.mockUserId = viewModel.userSession?.uid
        
        // Then
        XCTAssertEqual(mockUserId, viewModel.currentUser?.id)
        XCTAssertEqual(mockEmail, viewModel.currentUser?.email)
        XCTAssertEqual(mockUsername, viewModel.currentUser?.username)
    }
    
    @MainActor
    func test_AuthViewModel_signUp_shouldSetDatabaseProperly() async throws {
        // Given
        guard let viewModel = viewModel else {
            XCTFail("viewModel not initialised")
            return
        }
        
        XCTAssertNil(viewModel.userSession)
        
        // When
        /// Add data
        try await viewModel.signUp(withEmail: mockEmail, username: mockUsername, password: mockPassword)
        XCTAssertNotNil(viewModel.userSession)
        self.mockUserId = viewModel.userSession?.uid
        
        /// Retrieve data
        let userDocSnapshot = try await viewModel.databaseRef.collection("users").document(mockUserId ?? "").getDocument()
        if let userData = userDocSnapshot.data() {
            if let authData = userData["AuthenticationData"] as? [String: Any] {
                let id = authData["id"] as? String
                let email = authData["email"] as? String
                let username = authData["username"] as? String
                
                // Then
                XCTAssertEqual(id, mockUserId)
                XCTAssertEqual(email, mockEmail)
                XCTAssertEqual(username, mockUsername)
            } else {
                XCTFail("no authData")
            }
        } else {
            XCTFail("no data")
        }
    }
}
