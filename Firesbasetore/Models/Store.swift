//
//  Store.swift
//  FirebaseStoreApp
//
//  Created by 山本響 on 2021/05/30.
//

import Foundation

struct Store: Codable {
    var id: String?
    var name: String
    var address: String
    var items: [String]?
}
