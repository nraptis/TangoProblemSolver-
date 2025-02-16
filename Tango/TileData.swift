//
//  TileData.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import Foundation

struct TileData: Codable {
    var id: Int
    var gridX: Int
    var gridY: Int
    var symbol: SymbolModel
}
