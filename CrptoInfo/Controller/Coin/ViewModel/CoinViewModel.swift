//
//  CoinViewModel.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation

class CoinViewModel {
    private let useCase: CoinNetworkProvider?
    private var webSocket: CoinChangeNetworkProvider?
    var coinResult: (([Coin]) -> Void)?
    var fetchError: ((String) -> Void)?
    var webSocketError: ((String) -> Void)?
    var webSocketResponse: (([String : Any]) -> Void)?
    
    init(useCase: CoinNetworkProvider, webSocket: CoinChangeNetworkProvider) {
        self.useCase = useCase
        self.webSocket = webSocket
        
        self.webSocket?.coinResult = { _ in
            
        }
        
        self.webSocket?.fetchError = { [weak self] errorMessage in
            self?.webSocketError?(errorMessage)
        }
    }
    
}

extension CoinViewModel: CoinGuideline {
    func loadCoins(limit: Int, tsym: String, reloadTime: Int) {
        useCase?.fetchCoin(limit: limit, tsym: tsym, completion: { [weak self] result in
            switch result {
            case .success(let listCoin):
                self?.coinResult?(listCoin)
            case .failed(let error):
                if reloadTime > 0 {
                    self?.loadCoins(limit: limit, tsym: tsym, reloadTime: reloadTime - 1)
                    return
                }
                self?.fetchError?(error.localizedDescription)
            }
        })
    }
    
    func coinsWebSocket(coins: [Coin], toCurency: String, retryTime: Int) {
        webSocket?.connect(coins: coins, toCurency: "USD", completion: { [weak self] result in
            switch result {
            case .success(let isAllowed):
                print("Diperboleh kan untuk connect? \(isAllowed)")
            case .failed(let error):
                print("coinsWebSocket error: \(error.localizedDescription)")
                if retryTime > 0 {
                    self?.coinsWebSocket(coins: coins, toCurency: "USD", retryTime: retryTime - 1)
                    return
                }
                self?.webSocketError?("failed to connect cause: \(error.localizedDescription)")
            }
        })
    }
    
    func disconect() {
        webSocket?.disconect()
    }
}
