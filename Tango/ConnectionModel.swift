//
//  ConnectionModel.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import Foundation

@Observable class ConnectionModel {
    var gridX = 0
    var gridY = 0
    var id: Int
    var equalityModel = EqualityModel.none
    
    init(id: Int) {
        self.id = id
    }
}

extension ConnectionModel: Identifiable {
    
}

extension ConnectionModel: Hashable {
    static func == (lhs: ConnectionModel, rhs: ConnectionModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


