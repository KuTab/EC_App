//
//  Session.swift
//  EC_App
//
//  Created by Egor Dadugin on 29.01.2023.
//

import Foundation

struct Session: Decodable {
    var number: String
    var date: String
    var place: String
    var principal: String
    var name: String
    var achived: Bool
}
