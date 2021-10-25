//
//  MainViewModel.swift
//  Objectiver
//
//  Created by Борис Вашов on 18.10.2021.
//

import Foundation

class MenuViewModel : ObservableObject {
    
    @Inject var usersRepository: UsersRepository
    @Inject var appState: AppState
    
    @Published var isLoading = false
    
    func initialize() {
//        loadMe()
        print("MenuViewModel initialized")
    }
    
    private func loadMe() {
        isLoading = true
        
        usersRepository.loadMe() { result in
            switch result {
            case .success(let user):
                print("User phone: " + String(user.phone))
                DispatchQueue.main.async {
                    self.appState.userId = user.id
                }
                

            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        print("loadMe executed")
    }
}
