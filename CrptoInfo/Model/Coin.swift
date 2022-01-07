//
//  Coin.swift
//  CrptoInfo
//
//  Created by Mac on 04/01/22.
//

import Foundation
import SwiftyJSON

struct UsdCurency {
    let fromsymbol: String
    let toSymbol: String
    let market: String
    var price: Double
    let lastmarket: String
    var openDay: Double
    var change: Double
    var changePercent: String
}
extension UsdCurency {
    
    init(json: JSON) {
        fromsymbol = json["DISPLAY"]["USD"]["FROMSYMBOL"].stringValue
        toSymbol = json["DISPLAY"]["USD"]["TOSYMBOL"].stringValue
        market = json["RAW"]["USD"]["MARKET"].stringValue
        price = json["RAW"]["USD"]["PRICE"].doubleValue
        lastmarket = json["DISPLAY"]["USD"]["LASTMARKET"].stringValue
        openDay = json["RAW"]["USD"]["OPENDAY"].doubleValue
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
    var usdCurency: UsdCurency
}
extension Coin {
    
    init(json: JSON) {
        id = json["CoinInfo"]["Id"].stringValue
        name = json["CoinInfo"]["Name"].stringValue
        fullName = json["CoinInfo"]["FullName"].stringValue
        _internal = json["CoinInfo"]["Internal"].stringValue
        usdCurency = UsdCurency(json: json)
    }
}
