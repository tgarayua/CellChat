//
//  Message.swift
//  CellChat
//
//  Created by Thomas Garayua on 7/19/23.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
