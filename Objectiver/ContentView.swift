//
//  ContentView.swift
//  Objectiver
//
//  Created by Борис Вашов on 10.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject
    var appState: AppState = Resolver.shared.resolve(AppState.self)
    
//    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if appState.isLoggedIn {
            MenuView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
