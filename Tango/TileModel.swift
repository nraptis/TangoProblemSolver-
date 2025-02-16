//
//  TileModel.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import Foundation

@Observable class TileModel {
    
    var gridX = 0
    var gridY = 0
    
    var id: Int
    
    var symbol_original = SymbolModel.none
    var symbol_discovered = SymbolModel.none
    
    @ObservationIgnored var flag = SymbolModel.none
    
    var symbolOrFlag: SymbolModel {
        switch symbol_original {
        case .none:
            switch flag {
            case .none:
                return .none
            case .moon:
                return .moon
            case .sun:
                return .sun
            }
        case .moon:
            return .moon
        case .sun:
            return .sun
        }
    }
    
    // From *THIS* tile to the *RIGHT* tile.
    weak var connectionR: ConnectionModel?
    
    // From *THIS* tile to the *BELOW* tile.
    weak var connectionD: ConnectionModel?
    
    init(id: Int) {
        self.id = id
    }
}

extension TileModel: Identifiable {
    
}

extension TileModel: Hashable {
    static func == (lhs: TileModel, rhs: TileModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

