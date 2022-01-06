//
//  ListCoinUIGuide.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation
import UIKit
protocol ListCoinUIGuide {
    func showLoading(completion: (() -> Void)?)
    func hideLoading(completion: (() -> Void)?)
    func scrollControll(scrollView: UIScrollView, completion: (() -> Void)?)
}
