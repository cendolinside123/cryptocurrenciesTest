//
//  CoinChangeNetworkProvider.swift
//  CrptoInfo
//
//  Created by Mac on 07/01/22.
//

import Foundation

protocol CoinChangeNetworkProvider {
    func connect(coins: [Coin], toCurency: String, completion: (NetworkResult<Bool>) -> Void)
    func disconect()
    var coinResult: (([String: Any]) -> Void)? { get set }
    var fetchError: ((String) -> Void)? { get set }
}
