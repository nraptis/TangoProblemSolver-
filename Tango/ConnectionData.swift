//
//  ConnectionData.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import Foundation

struct ConnectionData: Codable {
    var id: Int
    var gridX: Int
    var gridY: Int
    var equalityModel: EqualityModel
}
