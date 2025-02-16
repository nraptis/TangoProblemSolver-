//
//  TileView.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import SwiftUI

struct NoBackgroundButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct TileView: View {
    
    @Environment(ViewModel.self) var viewModel
    
    let tile: TileModel
    let connectionR: ConnectionModel?
    let connectionD: ConnectionModel?
    
    var body: some View {
        
        let connectionSize = CGFloat(18.0)
        
        var width = CGFloat(56.0)
        var height = CGFloat(56.0)
        
        if connectionR !== nil {
            width += connectionSize
        }
        
        if connectionD !== nil {
            height += connectionSize
        }
        
        return HStack(spacing: 0.0) {
            
            VStack(spacing: 0.0) {
                
                
                Button {
                    
                    print("Clicked Tile: \(tile.gridX), \(tile.gridY)")
                    
                    let tile = viewModel.grid[tile.gridX][tile.gridY]
                    
                    print("Tile: \(tile.id)")
                    print("Self: \(self.tile.id)")
                    print("==== Same? ====")
                    
                    viewModel.clickTile(gridX: tile.gridX, gridY: tile.gridY)
                    
                } label: {
                    ZStack {
                        switch tile.symbol_original {
                        case .sun:
                            Text("☀️")
                                .font(.system(size: 32.0))
                        case .moon:
                            Text("🌑")
                                .font(.system(size: 32.0))
                        case .none:
                            switch tile.symbol_discovered {
                            case .sun:
                                Text("☀️")
                                    .font(.system(size: 32.0))
                                    .opacity(0.75)
                            case .moon:
                                Text("🌑")
                                    .font(.system(size: 32.0))
                                    .opacity(0.75)
                            case .none:
                                EmptyView()
                            }
                            
                        }
                    }
                    .frame(width: 54.0, height: 54.0)
                    .background(RoundedRectangle(cornerRadius: 10.0).foregroundStyle(Color.gray))
                }
                
                if let connection = connectionD {
                    
                    Button {
                        
                        print("Clicked Connection: \(connection.gridX), \(connection.gridY)")
                        
                        viewModel.clickConnectionV(gridX: connection.gridX, gridY: connection.gridY)
                        
                    } label: {
                        ZStack {
                            switch connection.equalityModel {
                            case .none:
                                EmptyView()
                            case .same:
                                Text("🟰")
                                    .font(.system(size: 12.0))
                            case .opposite:
                                Text("❌")
                                    .font(.system(size: 12.0))
                            }
                        }
                        .frame(width: connectionSize + connectionSize, height: connectionSize)
                        .background(RoundedRectangle(cornerRadius: 2.0).foregroundStyle(Color.white))
                    }
                    
                }
                
            }
            
            if let connection = connectionR {
                
                Button {
                    
                    print("Clicked Connection: \(connection.gridX), \(connection.gridY)")
                    
                    viewModel.clickConnectionH(gridX: connection.gridX, gridY: connection.gridY)
                    
                } label: {
                    ZStack {
                        switch connection.equalityModel {
                        case .none:
                            EmptyView()
                        case .same:
                            Text("🟰")
                                .font(.system(size: 12.0))
                        case .opposite:
                            Text("❌")
                                .font(.system(size: 12.0))
                        }
                    }
                    .frame(width: connectionSize, height: connectionSize + connectionSize)
                    .background(RoundedRectangle(cornerRadius: 2.0).foregroundStyle(Color.white))
                }
                
            }
            
        }
        .frame(width: width, height: height)
        .buttonStyle(NoBackgroundButtonStyle())
        
    }
}

#Preview {
    TileView(tile: TileModel(id: 0),
             connectionR: ConnectionModel(id: 0),
             connectionD: ConnectionModel(id: 1))
}
