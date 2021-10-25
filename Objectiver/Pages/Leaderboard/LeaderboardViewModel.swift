//
//  LeaderboardViewModel.swift
//  Objectiver
//
//  Created by Борис Вашов on 24.10.2021.
//

import Foundation

class LeaderboardViewModel: ObservableObject {
    @Published var isLoading = false
    
    @Inject var statisticsRepository: StatisticsRepository
    @Inject var appState: AppState
    
    @Published var usersStatistics: [UserStatistics] = []
    
    func initialize() {
        
        reload()
    }
    
    func reload() {
        isLoading = true
        
        statisticsRepository.getTop() { result in
            switch result {
            case .success(let userStatistics):
                self.usersStatistics.removeAll()
                self.usersStatistics.append(contentsOf: userStatistics)
                
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
