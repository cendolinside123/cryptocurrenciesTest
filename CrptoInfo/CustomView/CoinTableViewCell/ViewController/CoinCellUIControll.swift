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
        if coin.usdCurency.toSymbol == "" || coin.usdCurency.toSymbol == " " {
            return "-"
        } else {
            return "\(coin.usdCurency.toSymbol)\(coin.usdCurency.price)"
        }
    }
    
    func lableChangeValidation(coin: Coin, completion: (String, UIColor) -> Void) {
        
        if coin.usdCurency.toSymbol == "" || coin.usdCurency.toSymbol == " " {
            completion("-(-)",.gray)
            return
        }
        
        if coin.usdCurency.change.sign == .minus {
            completion("\(String(format: "%.2f", coin.usdCurency.change))(\(coin.usdCurency.changePercent))",.red)
        } else {
            completion("+\(String(format: "%.2f", coin.usdCurency.change))(\(coin.usdCurency.changePercent))",.green)
        }
    }
    
    
}
