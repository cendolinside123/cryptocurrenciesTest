//
//  CoinViewModel.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation

class CoinViewModel {
    private let useCase: CoinNetworkProvider?
    var coinResult: (([Coin]) -> Void)?
    var fetchError: ((String) -> Void)?
    
    init(useCase: CoinNetworkProvider) {
        self.useCase = useCase
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
}
