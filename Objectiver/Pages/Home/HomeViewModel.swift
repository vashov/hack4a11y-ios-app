//
//  DashboardViewModel.swift
//  Objectiver
//
//  Created by Борис Вашов on 18.10.2021.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    private var statisticsModel = StatisticsModel()
    
    @Inject var appState: AppState
    @Inject var statisticsRepository: StatisticsRepository
    @Inject var queriesRepository: QueriesRepository
    
    @Published var level = 0
    @Published var levelProgress = 0.0
    @Published var completedTaskCount = 0
    
    var isInitilized = false
    @Published var currentTasks: [TaskModel] = [TaskModel]()
    
    @Published var isLoadingStatistics = false
    @Published var isLoadingQueries = false
    var isLoading: Bool {
        isLoadingQueries || isLoadingStatistics
    }
    
    func initialize() {
        if isInitilized {
            return
        }
        isInitilized = true
         
//        currentTasks.append(TaskModel(queryId: 2, title: "Help with moving", date: "2021/10/24"))
//        currentTasks.append(TaskModel(queryId: 3, title: "Help with moving", date: "2021/10/24"))
//        currentTasks.append(TaskModel(queryId: 4, title: "Help with moving", date: "2021/10/24"))
//        currentTasks.append(TaskModel(queryId: 5, title: "Help with moving", date: "2021/10/24"))
        
        reload()
        
        print("Home initialized")
    }
    
    func reload() {
        loadQueries()
        loadStatistics()
    }
    
    private func loadStatistics() {
        isLoadingStatistics = true
        
        let userId = appState.userId
        statisticsRepository.getUserStatistics(userId: userId) { result in
            switch result {
            case .success(let userStatistics):
                self.setStatistics(userStatistics)
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.isLoadingStatistics = false
            }
        }
    }
    
    private func loadQueries() {
        isLoadingQueries = true
        
        queriesRepository.getAll() { result in
            switch result {
            case .success(let queries):
                self.setQueries(queries)
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.isLoadingQueries = false
            }
        }
    }
    
    private func setQueries(_ queries: [Query]) {
        let userId = appState.userId
        
        let filteredQueires = queries.filter { q in
            (q.executorId == userId || q.creatorId == userId) && !q.executed
        }
        .map { q in
            TaskModel(queryId: q.id, title: q.description, date: q.createdAt)
        }
        
        currentTasks.removeAll()
        currentTasks.append(contentsOf: filteredQueires)
    }
    
    private func setStatistics(_ userStatistics: UserStatistics) {
        DispatchQueue.main.async {
            
            self.level = (10 + userStatistics.finishedObjectives) / 10
            self.completedTaskCount = userStatistics.finishedObjectives
            self.levelProgress = Double(((10 + userStatistics.finishedObjectives)) - (self.level * 10)) / 10
        }
    }
    
}

struct TaskModel : Identifiable {
    var id = UUID()
    var queryId: Int
    var title: String
    var date: String
}
