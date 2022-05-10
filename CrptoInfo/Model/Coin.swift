//
//  Coin.swift
//  CrptoInfo
//
//  Created by Mac on 04/01/22.
//

import Foundation
import SwiftyJSON

struct Curency {
    let fromsymbol: String
    let toSymbol: String
    let market: String
    var price: Double
    let lastmarket: String
    var openDay: Double
    var change: Double
    var changePercent: String
}
extension Curency {
    
    init(json: JSON, curencyType: CurrencyName = .USD) {
        fromsymbol = json["DISPLAY"][curencyType.rawValue]["FROMSYMBOL"].stringValue
        toSymbol = json["DISPLAY"][curencyType.rawValue]["TOSYMBOL"].stringValue
        market = json["RAW"][curencyType.rawValue]["MARKET"].stringValue
        price = json["RAW"][curencyType.rawValue]["PRICE"].doubleValue
        lastmarket = json["DISPLAY"][curencyType.rawValue]["LASTMARKET"].stringValue
        openDay = json["RAW"][curencyType.rawValue]["OPENDAY"].doubleValue
        change = price - openDay
        changePercent = "\(String(format: "%.2f", (((price - openDay)/openDay) * 100)))%"
    }
    
    mutating func countChange() {
        change = price - openDay
        changePercent = "\(String(format: "%.2f", (((price - openDay)/openDay) * 100)))%"
    }
    
    init(fromsymbol: String, toSymbol: String, market: String, price: Double, lastmarket: String, openDay: Double) {
        self.fromsymbol = fromsymbol
        self.toSymbol = toSymbol
        self.market = market
        self.price = price
        self.lastmarket = lastmarket
        self.openDay = openDay
        change = price - openDay
        changePercent = "\(String(format: "%.2f", (((price - openDay)/openDay) * 100)))%"
    }
}

struct Coin {
    let id: String
    let name: String
    let fullName: String
    let _internal: String
    var curency: Curency
}
extension Coin {
    
    init(json: JSON, curencyType: CurrencyName = .USD) {
        id = json["CoinInfo"]["Id"].stringValue
        name = json["CoinInfo"]["Name"].stringValue
        fullName = json["CoinInfo"]["FullName"].stringValue
        _internal = json["CoinInfo"]["Internal"].stringValue
        curency = Curency(json: json, curencyType: curencyType)
    }
}
