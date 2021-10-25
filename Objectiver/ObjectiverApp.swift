//
//  ObjectiverApp.swift
//  Objectiver
//
//  Created by Борис Вашов on 10.10.2021.
//

import SwiftUI

@main
struct ObjectiverApp: App {
//    @StateObject var appState = AppState()
    
    // First invoke of Resolver, registrate all dependencies
    let resolver = Resolver.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(appState)
        }
    }
}
