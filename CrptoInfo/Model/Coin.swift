//
//  Coin.swift
//  CrptoInfo
//
//  Created by Mac on 04/01/22.
//

import Foundation
struct Coin {
    let Id: String
    let Name: String
    let FullName: String
    let Internal: String
    let fromsymbol: String
    let tosymbol: String
    let market: String
    var price: Double
    let lastmarket: String
    let openDay: Double
    var change: String
    var changePercent: String
    var toSymbol: String
}
extension Coin {
    mutating func countChange() {
        change = "\(price - openDay)"
        changePercent = "\(((price - openDay)/openDay) * 100)%"
    }
}
