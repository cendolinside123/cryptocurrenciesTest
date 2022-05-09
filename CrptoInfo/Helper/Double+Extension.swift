//
//  Double+Extension.swift
//  CrptoInfo
//
//  Created by Jan Sebastian on 09/05/22.
//

import Foundation
extension Double {
    var avoidNotation: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 8
        numberFormatter.numberStyle = .decimal
        
        let result = numberFormatter.string(for: self) ?? ""
        return result
    }
}
