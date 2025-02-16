//
//  TangoApp.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import SwiftUI

@main
struct TangoApp: App {
    
    let viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
