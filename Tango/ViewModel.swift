//
//  ViewModel.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import SwiftUI

@Observable class ViewModel {
    
    var paintModel = PaintModel.test
    var paintConnectionModel = EqualityModel.none
    
    init() {
        if !load() {
            size(width: 6,
                 height: 6)
        }
    }
    
    var tileID = 0
    var connectionID = 0
    
    var width = 0
    var height = 0
    
    var grid = [[TileModel]]()
    var connectionsH = [[ConnectionModel]]()
    var connectionsV = [[ConnectionModel]]()
    
    
    func clickTile(gridX: Int, gridY: Int) {
        if gridX >= 0 && gridX < width {
            if gridY >= 0 && gridY < height {
                switch paintModel {
                case .none:
                    grid[gridX][gridY].symbol_original = .none
                    print("Updated Tile \(gridX), \(gridY) to blank")
                case .sun:
                    grid[gridX][gridY].symbol_original = .sun
                    print("Updated Tile \(gridX), \(gridY) to sun")
                case .moon:
                    grid[gridX][gridY].symbol_original = .moon
                    print("Updated Tile \(gridX), \(gridY) to moon")
                case .test:
                    break;
                }
            }
        }
    }
    
    func clickConnectionH(gridX: Int, gridY: Int) {
        if gridX >= 0 && gridX < width {
            if gridY >= 0 && gridY < height {
                
                switch paintConnectionModel {
                case .none:
                    connectionsH[gridX][gridY].equalityModel = .none
                    print("Updated Connection Hor \(gridX), \(gridY) to none")
                case .same:
                    connectionsH[gridX][gridY].equalityModel = .same
                    print("Updated Connection Hor \(gridX), \(gridY) to same")
                case .opposite:
                    connectionsH[gridX][gridY].equalityModel = .opposite
                    print("Updated Connection Hor \(gridX), \(gridY) to opposite")
                }
            }
        }
    }
    
    func clickConnectionV(gridX: Int, gridY: Int) {
        if gridX >= 0 && gridX < width {
            if gridY >= 0 && gridY < height {
                
                switch paintConnectionModel {
                case .none:
                    connectionsV[gridX][gridY].equalityModel = .none
                    print("Updated Connection Ver \(gridX), \(gridY) to none")
                case .same:
                    connectionsV[gridX][gridY].equalityModel = .same
                    print("Updated Connection Ver \(gridX), \(gridY) to same")
                case .opposite:
                    connectionsV[gridX][gridY].equalityModel = .opposite
                    print("Updated Connection Ver \(gridX), \(gridY) to opposite")
                }
            }
        }
    }
    
    func size(width: Int, height: Int) {
        
        var _width = width
        if _width < 3 { _width = 3 }
        
        var _height = height
        if _height < 3 { _height = 3 }
        
        var _grid = [[TileModel]](repeating: [TileModel](), count: _width)
        for x in 0..<_width {
            for y in 0..<_height {
                let tileModel = TileModel(id: tileID)
                tileModel.gridX = x
                tileModel.gridY = y
                _grid[x].append(tileModel)
                tileID += 1
            }
        }
        
        for x in 0..<self.width {
            for y in 0..<self.height {
                if x < _width && y < _height {
                    _grid[x][y].symbol_original = grid[x][y].symbol_original
                }
            }
        }
        
        var _connectionsH = [[ConnectionModel]](repeating: [ConnectionModel](), count: _width)
        for x in 0..<_width {
            for y in 0..<_height {
                let connectionModel = ConnectionModel(id: connectionID)
                connectionModel.gridX = x
                connectionModel.gridY = y
                _connectionsH[x].append(connectionModel)
                connectionID += 1
            }
        }
        
        if self.width > 0 && self.height > 0 {
            for x in 0..<self.width {
                for y in 0..<self.height {
                    if x < _width && y < _height {
                        _connectionsH[x][y].equalityModel = connectionsH[x][y].equalityModel
                    }
                }
            }
        }
        
        var _connectionsV = [[ConnectionModel]](repeating: [ConnectionModel](), count: _width)
        for x in 0..<_width {
            for y in 0..<_height {
                let connectionModel = ConnectionModel(id: connectionID)
                connectionModel.gridX = x
                connectionModel.gridY = y
                _connectionsV[x].append(connectionModel)
                connectionID += 1
            }
        }
        
        if self.width > 0 && self.height > 0 {
            for x in 0..<self.width {
                for y in 0..<self.height {
                    if x < _width && y < _height {
                        _connectionsV[x][y].equalityModel = connectionsV[x][y].equalityModel
                    }
                }
            }
        }
        
        self.width = _width
        self.height = _height
        self.grid = _grid
        self.connectionsH = _connectionsH
        self.connectionsV = _connectionsV
        
        for x in 0..<_width {
            for y in 0..<_height {
                let tileModel = grid[x][y]
                
                if x < (_width - 1) {
                        tileModel.connectionR = connectionsH[x][y]
                    
                }
                if y < (_height - 1) {
                        tileModel.connectionD = connectionsV[x][y]
                    
                }
                
            }
        }
        
        print("Sizing to \(width) x \(height)")
    }
    
    @MainActor func width_increase() {
        print("width_increase")
        size(width: width + 1, height: height)
    }
    
    @MainActor func width_decrease() {
        print("width_decrease")
        size(width: width - 1, height: height)
    }
    
    @MainActor func height_increase() {
        print("height_increase")
        size(width: width, height: height + 1)
    }
    
    @MainActor func height_decrease() {
        print("height_decrease")
        size(width: width, height: height - 1)
    }

    var numberOfLoops = 0
    @MainActor func solve() {
        print("solve!")
        
        for x in 0..<width {
            for y in 0..<height {
                grid[x][y].flag = .none
                grid[x][y].symbol_discovered = .none
            }
        }
        
        if search(0, 0) {
            print("A valid grid was found! Searched \(numberOfLoops) times!")
            for x in 0..<width {
                for y in 0..<height {
                    if grid[x][y].symbol_original == .none {
                        grid[x][y].symbol_discovered = grid[x][y].flag
                    }
                }
            }
        } else {
            print("A valid grid was not found! Searched \(numberOfLoops) times!")
            
        }
    }
    
    func search(_ gridX: Int, _ gridY: Int) -> Bool {
        
        numberOfLoops += 1
        
        

        return false
    }
    
    func validBoard() -> Bool {

        
        
        return true
    }

    
    func getTile(_ gridX: Int, _ gridY: Int) -> TileModel? {
        if gridX >= 0 && gridX < width && gridY >= 0 && gridY < height {
            return grid[gridX][gridY]
        }
        return nil
    }
}

extension ViewModel {
    
    func save() {
        let gridData = GridData(
            width: width,
            height: height,
            tiles: grid.flatMap { $0.map { tile in
                TileData(id: tile.id, gridX: tile.gridX, gridY: tile.gridY, symbol: tile.symbol_original)
            }},
            connectionsH: connectionsH.flatMap { $0.map { connection in
                ConnectionData(id: connection.id, gridX: connection.gridX, gridY: connection.gridY, equalityModel: connection.equalityModel)
            }},
            connectionsV: connectionsV.flatMap { $0.map { connection in
                ConnectionData(id: connection.id, gridX: connection.gridX, gridY: connection.gridY, equalityModel: connection.equalityModel)
            }}
        )

        let fileURL = getDocumentsDirectory().appendingPathComponent("gridData.json")

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(gridData)
            try data.write(to: fileURL)
            print("Saved grid data to \(fileURL)")
        } catch {
            print("Failed to save grid data: \(error)")
        }
    }
    
    func load() -> Bool {
        let fileURL = getDocumentsDirectory().appendingPathComponent("gridData.json")

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let gridData = try decoder.decode(GridData.self, from: data)

            if gridData.width < 3 || gridData.height < 3 {
                return false
            }

            // Resize grid first
            self.size(width: gridData.width, height: gridData.height)

            // Restore tile symbols
            for tile in gridData.tiles {
                if tile.gridX < width && tile.gridY < height {
                    grid[tile.gridX][tile.gridY].symbol_original = tile.symbol
                }
            }

            // Restore horizontal connections
            for connection in gridData.connectionsH {
                if connection.gridX < width - 1 && connection.gridY < height {
                    connectionsH[connection.gridX][connection.gridY].equalityModel = connection.equalityModel
                }
            }

            // Restore vertical connections
            for connection in gridData.connectionsV {
                if connection.gridX < width && connection.gridY < height - 1 {
                    connectionsV[connection.gridX][connection.gridY].equalityModel = connection.equalityModel
                }
            }

            // Re-assign tile connections
            for x in 0..<width {
                for y in 0..<height {
                    let tile = grid[x][y]
                    if x < width - 1 {
                        tile.connectionR = connectionsH[x][y]
                    }
                    if y < height - 1 {
                        tile.connectionD = connectionsV[x][y]
                    }
                }
            }

            print("Loaded grid data from \(fileURL)")
            return true
        } catch {
            print("Failed to load grid data: \(error)")
            return false
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

