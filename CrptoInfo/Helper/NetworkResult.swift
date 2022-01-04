//
//  NetworkResult.swift
//  CrptoInfo
//
//  Created by Mac on 04/01/22.
//

import Foundation
enum NetworkResult<T> {
    case success(T)
    case failed(Error)
}
