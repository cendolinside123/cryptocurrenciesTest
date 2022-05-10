//
//  ListNewsUT.swift
//  CrptoInfoTests
//
//  Created by Mac on 07/01/22.
//

import XCTest
@testable import CrptoInfo

class ListNewsUT: XCTestCase {
    func testSucessLoad_offlineTest() {
        let viewModel = NewsViewModel(useCase: SuccessNewsUseCase())
        let expectedResult = MockData.generateNewsList()
        let expect = expectation(description: "Should return news data")
        
        viewModel.newsResult = { result in
            XCTAssertEqual(result, expectedResult)
            expect.fulfill()
        }
        viewModel.loadNews(category: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 1)
    }
    
    func testFailedLoad_offlineTest() {
        let viewModel = NewsViewModel(useCase: FailedNewsUseCase())
        let expect = expectation(description: "Should error")
        
        viewModel.fetchError = { errorMessage in
            print("error message: \(errorMessage)")
            
            expect.fulfill()
        }
        viewModel.loadNews(category: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 1)
    }
    
    func testSucessLoad_OnlineTest() {
        let viewModel = NewsViewModel(useCase: NewsUseCase())
        let expect = expectation(description: "Should return news data")
        
        viewModel.newsResult = { result in
            XCTAssertGreaterThan(result.count, 0, "ada data yg ditampilkan")
            expect.fulfill()
        }
        viewModel.loadNews(category: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 10)
    }
    
    func testFailedLoad_OnlineTest() {
        let viewModel = NewsViewModel(useCase: NewsUseCase())
        let expect = expectation(description: "Data empty or error")
        
        viewModel.newsResult = { result in
            XCTAssertEqual(result.count, 0)
            expect.fulfill()
        }
        
        viewModel.fetchError = { errorMessage in
            print("error message: \(errorMessage)")
            
            expect.fulfill()
        }
        
        viewModel.loadNews(category: "", reloadTime: 3)
        wait(for: [expect], timeout: 10)
        
    }

}
