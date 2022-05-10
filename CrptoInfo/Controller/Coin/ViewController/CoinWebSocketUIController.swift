//
//  CoinWebSocketUIController.swift
//  CrptoInfo
//
//  Created by Mac on 07/01/22.
//

import Foundation
import UIKit

class CoinWebSocketUIController {
    private weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
}
extension CoinWebSocketUIController: CoinWebSocketUIGuide {
    func editListData(newValue: [String : Any]) {
        guard let _controller = controller as? ListCoinViewController else {
            return
        }
        
        guard let getIndex = _controller.getListCoin().firstIndex(where: { coin in
            
            guard let getName = newValue["FROMSYMBOL"] as? String else{
                return false
            }
            
            return coin.name == getName
        }) else {
            return
        }
        let selectedCoin = _controller.getListCoin()[getIndex]
        if let price = newValue["PRICE"] as? Double {
            var usdValue: Curency
            if let openDay = newValue["OPENDAY"] as? Double {
                usdValue = Curency(fromsymbol: selectedCoin.curency.fromsymbol, toSymbol: selectedCoin.curency.toSymbol, market: selectedCoin.curency.market, price: price, lastmarket: selectedCoin.curency.lastmarket, openDay: openDay)
            } else {
                usdValue = Curency(fromsymbol: selectedCoin.curency.fromsymbol, toSymbol: selectedCoin.curency.toSymbol, market: selectedCoin.curency.market, price: price, lastmarket: selectedCoin.curency.lastmarket, openDay: selectedCoin.curency.openDay)
            }
            let getCoin = Coin(id: selectedCoin.id, name: selectedCoin.name, fullName: selectedCoin.fullName, _internal: selectedCoin._internal, curency: usdValue)
            _controller.updatePriceSelectedData(index: getIndex, coin: getCoin)
            
            
        }
    }
    
    
}
