//
//  GridData.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import Foundation

struct GridData: Codable {
    var width: Int
    var height: Int
    var tiles: [TileData]
    var connectionsH: [ConnectionData]
    var connectionsV: [ConnectionData]
    
}
