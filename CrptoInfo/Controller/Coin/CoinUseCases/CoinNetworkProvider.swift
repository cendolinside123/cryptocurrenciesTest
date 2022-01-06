//
//  CoinNetworkProvider.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation

protocol CoinNetworkProvider {
    func fetchCoin(limit: Int, tsym: String, completion: @escaping (NetworkResult<[Coin]>) -> Void)
}
