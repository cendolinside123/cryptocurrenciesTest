//
//  ListCoinUT.swift
//  CrptoInfoTests
//
//  Created by Mac on 07/01/22.
//

import XCTest
@testable import CrptoInfo

class ListCoinUT: XCTestCase {

    func testSucessLoad_offlineTest() {
        var viewModel: CoinGuideline = CoinViewModel(useCase: CointUseCase(cointDataSource: SuccessCoinListUseCase(), coinDataRealtime: nil))
        let expectedResult = MockData.generateCoinList()
        let expect = expectation(description: "Should return coin data")
        
        viewModel.coinResult = { result in
            XCTAssertEqual(viewModel.listCoin, expectedResult)
            expect.fulfill()
        }
        viewModel.loadCoins(limit: 1, tsym: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 1)
    }
    
    func testRefetch_offlineTest() {
        var viewModel: CoinGuideline = CoinViewModel(useCase: CointUseCase(cointDataSource: SuccessCoinListUseCaseV2(), coinDataRealtime: nil))
        let expectedResult = MockData.generateCoinListV2()
        let expect = expectation(description: "Should return coin data")
        viewModel.listCoin = MockData.generateCoinList()
        viewModel.coinResult = { result in
            XCTAssertEqual(viewModel.listCoin, expectedResult)
            expect.fulfill()
        }
        viewModel.loadCoins(limit: 2, tsym: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 1)
    }
    
    func testRefetch_offlineTestV2() {
        var viewModel: CoinGuideline = CoinViewModel(useCase: CointUseCase(cointDataSource: SuccessCoinListUseCase(), coinDataRealtime: nil))
        let expectedResult = MockData.generateCoinList()
        let expect = expectation(description: "Should return coin data")
        viewModel.listCoin = MockData.generateCoinListV2()
        viewModel.coinResult = { result in
            XCTAssertEqual(viewModel.listCoin, expectedResult)
            expect.fulfill()
        }
        viewModel.loadCoins(limit: 1, tsym: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 1)
    }
    
    func testRefetch_offlineTestV3() {
        var viewModel: CoinGuideline = CoinViewModel(useCase: CointUseCase(cointDataSource: SuccessCoinListUseCaseV2(), coinDataRealtime: nil))
        let expectedResult = MockData.generateCoinListV4()
        let expect = expectation(description: "Should return coin data")
        viewModel.listCoin = MockData.generateCoinListV3()
        viewModel.coinResult = { result in
            XCTAssertEqual(viewModel.listCoin, expectedResult)
            expect.fulfill()
        }
        viewModel.loadCoins(limit: 2, tsym: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 1)
    }
    
    func testFailedLoad_offlineTest() {
        var viewModel: CoinGuideline = CoinViewModel(useCase: CointUseCase(cointDataSource: FailedCoinListUseCase(), coinDataRealtime: nil))
        let expect = expectation(description: "Should failed load")
        
        viewModel.fetchError = { errorMessage in
            print("message: \(errorMessage)")
            expect.fulfill()
        }
        viewModel.loadCoins(limit: 1, tsym: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 1)
    }
    
    func testSucessLoad_onlineTest() {
        var viewModel: CoinGuideline = CoinViewModel(useCase: CointUseCase(cointDataSource: CoinUseCase(), coinDataRealtime: nil))
        let expect = expectation(description: "Should return coin data")
        
        viewModel.coinResult = { listCoin in
            XCTAssertGreaterThan(listCoin.count,0,"ada data yang ditampilkan")
            expect.fulfill()
        }
        viewModel.loadCoins(limit: 50, tsym: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 10)
    }
    
    func testFailedLoad_onlineTest() {
        var viewModel: CoinGuideline = CoinViewModel(useCase: CointUseCase(cointDataSource: CoinUseCase(), coinDataRealtime: nil))
        let expect = expectation(description: "Should get empty data cause difference currency")
        
        viewModel.fetchError = { errorMessage in
            print("message: \(errorMessage)")
            expect.fulfill()
        }
        
        viewModel.coinResult = { coin in
            XCTAssertEqual(coin.count, 0)
            expect.fulfill()
        }
        viewModel.loadCoins(limit: 50, tsym: "aaaaaaaaaaa", reloadTime: 3)
        wait(for: [expect], timeout: 10)
    }
}
