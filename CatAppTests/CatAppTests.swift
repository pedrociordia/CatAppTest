//
//  CatAppTests.swift
//  CatAppTests
//
//  Created by Pedro Ciordia Cagigal on 2/8/22.
//

import XCTest
import Combine
@testable import CatApp

class CatAppTests: XCTestCase {
    
    
    private var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchAllCatBreeds() throws {
        
        let expectation = self.expectation(description: "waiting response")

        
        CombineClient().fetchAllCatBreeds()
            .sink { res in
                switch res {
                case .failure(let error):
                    XCTFail("Fail with: \(String(describing: error.errorDescription))")
                    expectation.fulfill()
                default: break
                }
            } receiveValue: { model in
                XCTAssert(model.count > 0)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchCatBreedsByName() throws {
        
        let expectation = self.expectation(description: "waiting response")
        
        CombineClient().fetchCatBreedsByName("Abyssinian")
            .sink { res in
                switch res {
                case .failure(let error):
                    XCTFail("Fail with: \(String(describing: error.errorDescription))")
                    expectation.fulfill()
                default: break
                }
            } receiveValue: { model in
                XCTAssertNotNil(model.first)
                XCTAssert(model.first?.name ?? "" == "Abyssinian")
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
    
    }
}
