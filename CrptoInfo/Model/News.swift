//
//  News.swift
//  CrptoInfo
//
//  Created by Mac on 04/01/22.
//

import Foundation
import SwiftyJSON

struct SourceInfo {
    let name: String
    let lang: String
    let img: String
}

extension SourceInfo {
    init(json: JSON) {
        name = json["source_info"]["name"].stringValue
        lang = json["source_info"]["lang"].stringValue
        img = json["source_info"]["img"].stringValue
    }
}

struct News {
    let id: String
    let guid: String
    let title: String
    let source: String
    let body: String
    let tags: String
    let categories: String
    let source_info: SourceInfo
}
extension News {
    init(json: JSON) {
        id = json["id"].stringValue
        guid = json["guid"].stringValue
        title = json["title"].stringValue
        source = json["source"].stringValue
        body = json["body"].stringValue
        tags = json["tags"].stringValue
        categories = json["categories"].stringValue
        source_info = SourceInfo(json: json)
    }
}
