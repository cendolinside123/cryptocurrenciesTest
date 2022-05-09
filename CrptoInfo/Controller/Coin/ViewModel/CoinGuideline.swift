//
//  CoinGuideline.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation

protocol CoinGuideline {
    func loadCoins(limit: Int, tsym: String, reloadTime: Int)
    func coinsWebSocket(coins: [Coin], toCurency: String, retryTime: Int)
    func disconect()
    var coinResult: (([Coin]) -> Void)? { get set }
    var fetchError: ((String) -> Void)? { get set }
    var webSocketError: ((String) -> Void)? { get set }
    var webSocketResponse: (([String : Any]) -> Void)? { get set }
}

struct CointUseCase {
    let cointDataSource: CoinNetworkProvider
    let coinDataRealtime: CoinChangeNetworkProvider?
}
