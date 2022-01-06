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
    var change: String
    var changePercent: String
}
extension UsdCurency {
    
    init(json: JSON) {
        fromsymbol = json["DISPLAY"]["USD"]["FROMSYMBOL"].stringValue
        toSymbol = json["DISPLAY"]["USD"]["TOSYMBOL"].stringValue
        market = json["RAW"]["USD"]["MARKET"].stringValue
        price = json["RAW"]["USD"]["MARKET"].doubleValue
        lastmarket = json["DISPLAY"]["USD"]["LASTMARKET"].stringValue
        openDay = json["RAW"]["USD"]["OPENDAY"].doubleValue
        change = "\(price - openDay)"
        changePercent = "\(((price - openDay)/openDay) * 100)%"
    }
    
    mutating func countChange() {
        change = "\(price - openDay)"
        changePercent = "\(((price - openDay)/openDay) * 100)%"
    }
}

struct Coin {
    let id: String
    let name: String
    let fullName: String
    let _internal: String
    let usdCurency: UsdCurency
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
