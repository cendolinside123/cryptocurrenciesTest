//
//  CoinCellUIControll.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation
import UIKit

struct CoinCellUIControll {
}
extension CoinCellUIControll: CoinCellUIGuide {
    func priceValidation(coin: Coin) -> String {
        if coin.curency.toSymbol == "" || coin.curency.toSymbol == " " {
            return "-"
        } else {
            return "\(coin.curency.toSymbol)\(coin.curency.price.avoidNotation)"
        }
    }
    
    func lableChangeValidation(coin: Coin, completion: (String, UIColor) -> Void) {
        
        if coin.curency.toSymbol == "" || coin.curency.toSymbol == " " {
            completion("-(-)",.gray)
            return
        }
        
        if coin.curency.change.sign == .minus {
            completion("\(String(format: "%.2f", coin.curency.change))(\(coin.curency.changePercent))",.red)
        } else {
            completion("+\(String(format: "%.2f", coin.curency.change))(\(coin.curency.changePercent))",.green)
        }
    }
    
    
}
