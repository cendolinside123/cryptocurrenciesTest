//
//  String+Extension.swift
//  CrptoInfo
//
//  Created by Jan Sebastian on 10/05/22.
//

import Foundation


extension String {
    var urlAPI: String {
        return Constants.URL.baseURL + self
    }
}
