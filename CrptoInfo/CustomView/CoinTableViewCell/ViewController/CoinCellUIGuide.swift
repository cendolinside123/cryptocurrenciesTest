//
//  CoinCellUIGuide.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation
import UIKit

protocol CoinCellUIGuide {
    func priceValidation(coin: Coin) -> String
    func lableChangeValidation(coin: Coin, completion: (String, UIColor) -> Void)
}
