//
//  GridView.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import SwiftUI

struct GridView: View {
    
    @Environment(ViewModel.self) var viewModel
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            HStack(spacing: 0.0) {
                ForEach(viewModel.grid, id: \.self) { column in
                    VStack(spacing: 0.0) {
                        ForEach(column) { tile in
                            TileView(tile: tile,
                                     connectionR: tile.connectionR,
                                     connectionD: tile.connectionD)
                        }
                    }
                }
            }
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    GridView(width: 800,
             height: 800)
}
