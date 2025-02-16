//
//  SymbolModel.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import Foundation

enum SymbolModel: UInt8 {
    case none
    case moon
    case sun
}

extension SymbolModel: Codable {
    
}
