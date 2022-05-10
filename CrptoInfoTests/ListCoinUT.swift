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
                XCTAssertEqual(responseItem.curency.fromsymbol, expectedResult[indexLoop].curency.fromsymbol)
                XCTAssertEqual(responseItem.curency.toSymbol, expectedResult[indexLoop].curency.toSymbol)
                XCTAssertEqual(responseItem.curency.openDay, expectedResult[indexLoop].curency.openDay)
                XCTAssertEqual(responseItem.curency.price, expectedResult[indexLoop].curency.price)
                XCTAssertEqual(responseItem.curency.change, expectedResult[indexLoop].curency.change)
                XCTAssertEqual(responseItem.curency.changePercent, expectedResult[indexLoop].curency.changePercent)
                XCTAssertEqual(responseItem.curency.market, expectedResult[indexLoop].curency.market)
                XCTAssertEqual(responseItem.curency.lastmarket, expectedResult[indexLoop].curency.lastmarket)
                
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
