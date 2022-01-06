//
//  CoinGuideline.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation

protocol CoinGuideline {
    func loadCoins(limit: Int, tsym: String, reloadTime: Int)
    var coinResult: (([Coin]) -> Void)? { get set }
    var fetchError: ((String) -> Void)? { get set }
}
