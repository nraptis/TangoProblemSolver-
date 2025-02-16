//
//  ContentView.swift
//  Tango
//
//  Created by Nicholas Raptis on 2/16/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(ViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        return VStack(spacing: 0.0) {
            HStack {
                Spacer()
                Button {
                    viewModel.width_decrease()
                } label: {
                    ZStack {
                        Text("Width -= 1")
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 144.0, height: 44.0)
                    .background(RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.blue))
                }
                Button {
                    viewModel.width_increase()
                } label: {
                    ZStack {
                        Text("Width += 1")
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 144.0, height: 44.0)
                    .background(RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.blue))
                }
                
                Spacer()
                
                Button {
                    viewModel.height_decrease()
                } label: {
                    ZStack {
                        Text("Height -= 1")
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 144.0, height: 44.0)
                    .background(RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.blue))
                }
                Button {
                    viewModel.height_increase()
                } label: {
                    ZStack {
                        Text("Height += 1")
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 144.0, height: 44.0)
                    .background(RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.blue))
                }
                Spacer()
            }
            .frame(height: 44.0)
            
            VStack {
                HStack {
                    Picker("", selection: $viewModel.paintModel) {
                        Text("None").tag(PaintModel.none)
                        Text("Sun").tag(PaintModel.sun)
                        Text("Moon").tag(PaintModel.moon)
                        Text("Test").tag(PaintModel.test)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .frame(height: 44.0)
            
            VStack {
                HStack {
                    Picker("", selection: $viewModel.paintConnectionModel) {
                        Text("None").tag(EqualityModel.none)
                        Text("Same").tag(EqualityModel.same)
                        Text("Opposite").tag(EqualityModel.opposite)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .frame(height: 44.0)
            
            HStack(spacing: 0.0) {
                VStack {
                    
                }
                .frame(width: 256.0)
                
                GeometryReader { geometry in
                    GridView(width: geometry.size.width,
                             height: geometry.size.height)
                }
                .background(Color.pink)
                
                VStack {
                    Button {
                        viewModel.solve()
                    } label: {
                        ZStack {
                            Text("Solve")
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 144.0, height: 44.0)
                        .background(RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.blue))
                    }
                    
                    Button {
                        
                        viewModel.save()
                    } label: {
                        ZStack {
                            Text("Save")
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 144.0, height: 44.0)
                        .background(RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.blue))
                    }
                    
                    Button {
                        
                        _ = viewModel.load()
                    } label: {
                        ZStack {
                            Text("Load")
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 144.0, height: 44.0)
                        .background(RoundedRectangle(cornerRadius: 16.0).foregroundStyle(Color.blue))
                    }
                }
                .frame(width: 256.0)
            }
        }
        .frame(width: 1200, height: 800)
    }
}

#Preview {
    ContentView()
}
