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
        var viewModel: CoinGuideline = CoinViewModel(useCase: CointUseCase(cointDataSource: CoinUseCase(), coinDataRealtime: nil))
        let expectedResult = MockData.generateCoinList()
        let expect = expectation(description: "Should return coin data")
        
        viewModel.coinResult = { result in
            var indexLoop = 0
            for responseItem in result {
                
                XCTAssertEqual(responseItem.id, expectedResult[indexLoop].id)
                XCTAssertEqual(responseItem.name, expectedResult[indexLoop].name)
                XCTAssertEqual(responseItem.fullName, expectedResult[indexLoop].fullName)
                XCTAssertEqual(responseItem._internal, expectedResult[indexLoop]._internal)
                XCTAssertEqual(responseItem.usdCurency.fromsymbol, expectedResult[indexLoop].usdCurency.fromsymbol)
                XCTAssertEqual(responseItem.usdCurency.toSymbol, expectedResult[indexLoop].usdCurency.toSymbol)
                XCTAssertEqual(responseItem.usdCurency.openDay, expectedResult[indexLoop].usdCurency.openDay)
                XCTAssertEqual(responseItem.usdCurency.price, expectedResult[indexLoop].usdCurency.price)
                XCTAssertEqual(responseItem.usdCurency.change, expectedResult[indexLoop].usdCurency.change)
                XCTAssertEqual(responseItem.usdCurency.changePercent, expectedResult[indexLoop].usdCurency.changePercent)
                XCTAssertEqual(responseItem.usdCurency.market, expectedResult[indexLoop].usdCurency.market)
                XCTAssertEqual(responseItem.usdCurency.lastmarket, expectedResult[indexLoop].usdCurency.lastmarket)
                
                indexLoop = indexLoop + 1
            }
            expect.fulfill()
        }
        viewModel.loadCoins(limit: 1, tsym: "USD", reloadTime: 3)
        wait(for: [expect], timeout: 1)
    }
    
    func testFailedLoad_offlineTest() {
        var viewModel: CoinGuideline = CoinViewModel(useCase: CointUseCase(cointDataSource: CoinUseCase(), coinDataRealtime: nil))
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
