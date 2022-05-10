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
extension SourceInfo: Equatable {
    static func == (lhs: SourceInfo, rhs: SourceInfo) -> Bool {
        return lhs.name == rhs.name &&
        lhs.lang == rhs.lang &&
        lhs.img == rhs.img
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
extension News: Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.id == rhs.id &&
        lhs.guid == rhs.guid &&
        lhs.title == rhs.title &&
        lhs.source == rhs.source &&
        lhs.body == rhs.body &&
        lhs.tags == rhs.tags &&
        lhs.categories == rhs.categories &&
        lhs.source_info == rhs.source_info
    }
}
