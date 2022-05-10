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
    var listCoin: [Coin] = []
    
    init(useCase: CointUseCase) {
        self.useCase = useCase.cointDataSource
        self.webSocket = useCase.coinDataRealtime
        
        self.webSocket?.coinResult = { [weak self] getCoinChange in
            self?.webSocketResponse?(getCoinChange)
        }
        
        self.webSocket?.fetchError = { [weak self] errorMessage in
            self?.webSocketError?(errorMessage)
        }
    }
    
}

extension CoinViewModel: CoinGuideline {
    func loadCoins(limit: Int, tsym: String, reloadTime: Int) {
        
        var tempListCoin: [Coin] = []
        var errorMessage: Error? = nil
        let groupDispatch: DispatchGroup = DispatchGroup()
        groupDispatch.enter()
        useCase?.fetchCoin(limit: limit, tsym: tsym, completion: { result in
            switch result {
            case .success(let listCoin):
                tempListCoin = listCoin
            case .failed(let error):
                errorMessage = error
            }
            groupDispatch.leave()
        })
        
        groupDispatch.notify(queue: .global(), execute: { [weak self] in
            
            guard let superSelf = self else {
                if reloadTime > 0 {
                    self?.loadCoins(limit: limit, tsym: tsym, reloadTime: reloadTime - 1)
                    return
                }
                self?.fetchError?(ErrorMessage.unknow.localizedDescription)
                return
            }
            
            if let getError = errorMessage {
                if reloadTime > 0 {
                    self?.loadCoins(limit: limit, tsym: tsym, reloadTime: reloadTime - 1)
                    return
                }
                self?.fetchError?(getError.localizedDescription)
                return
            }
            
            if superSelf.listCoin.count == 0 {
                superSelf.listCoin = tempListCoin
                superSelf.coinResult?(tempListCoin)
            } else {
                if superSelf.listCoin.count != tempListCoin.count {
                    if superSelf.listCoin.count < tempListCoin.count {
                        var newItems: [Coin] = []
                        for getItemList1 in tempListCoin {
                            for index in 0...(superSelf.listCoin.count - 1) {
                                if getItemList1.name == superSelf.listCoin[index].name &&
                                    getItemList1.id == superSelf.listCoin[index].id &&
                                    getItemList1.fullName == superSelf.listCoin[index].fullName &&
                                    getItemList1._internal == superSelf.listCoin[index]._internal
                                {
                                    break
                                }

                                if index == (superSelf.listCoin.count - 1) {
                                    newItems.append(getItemList1)
                                }
                            }
                        }
                        
                        superSelf.listCoin += newItems
                        superSelf.coinResult?(superSelf.listCoin)
                        
                    } else if superSelf.listCoin.count > tempListCoin.count {
                        var invalidItems: [Coin] = []
                        for getItemList1 in superSelf.listCoin {
                            for index in 0...(tempListCoin.count - 1) {
                                if getItemList1.name == tempListCoin[index].name &&
                                    getItemList1.id == superSelf.listCoin[index].id &&
                                    getItemList1.fullName == superSelf.listCoin[index].fullName &&
                                    getItemList1._internal == superSelf.listCoin[index]._internal
                                {
                                    break
                                }

                                if index == (tempListCoin.count - 1) {
                                    invalidItems.append(getItemList1)
                                }
                            }
                            
                            
                        }
                        var newData: [Coin] = []
                        for getItemList1 in superSelf.listCoin {
                            for index in 0...(invalidItems.count - 1) {
                                if getItemList1.name == invalidItems[index].name &&
                                    getItemList1.id == invalidItems[index].id &&
                                    getItemList1.fullName == invalidItems[index].fullName &&
                                    getItemList1._internal == invalidItems[index]._internal
                                {
                                    break
                                }
                                
                                if index == (tempListCoin.count - 1) {
                                    newData.append(getItemList1)
                                }
                                
                            }
                        }
                        superSelf.listCoin = newData
                        superSelf.coinResult?(newData)
                    }
                } else {
                    superSelf.coinResult?(superSelf.listCoin)
                }
                
            }
            
        })
    }
    
    func coinsWebSocket(coins: [Coin], toCurency: String, retryTime: Int) {
        webSocket?.connect(coins: coins, toCurency: toCurency, completion: { [weak self] result in
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
