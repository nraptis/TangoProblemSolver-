//
//  EqualityModel.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import Foundation

enum EqualityModel: UInt8 {
    case none
    case same
    case opposite
}

extension EqualityModel: Codable {
    
}
