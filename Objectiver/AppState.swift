//
//  AppState.swift
//  Objectiver
//
//  Created by Борис Вашов on 10.10.2021.
//

 import Foundation

 class AppState: ObservableObject {
    @Published var isLoggedIn = false
    var accessToken: String = ""
    var userId: Int = 0
    var roles: [String] = []
    
    var isCreator: Bool {
        roles.contains("Creator")
    }
    
    var isExecuter: Bool {
        roles.contains("Executor")
    }
    
//    @Published var userData = UserData()
//    @Published var routing = ViewRouting()
//    @published var system = System()
    
    func signIn(token: String, userId: Int, roles: [String]) {
        self.accessToken = token
        self.userId = userId
        self.roles.append(contentsOf: roles)
        self.isLoggedIn = true
    }
    
    func signOut() {
        accessToken = ""
        userId = 0
        roles.removeAll()
        isLoggedIn = false
    }
 }
