//
//  QueryDetailsViewModel.swift
//  Objectiver
//
//  Created by Борис Вашов on 23.10.2021.
//

import Foundation

class QueryViewModel : ObservableObject {
    
    @Inject var queriesRepository: QueriesRepository
    @Inject var appState: AppState
    
    let queryId: Int?
    
    @Published var description: String = ""
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    @Published var isLoading: Bool = false
    @Published var creatorId: Int?
    @Published var executorId: Int?
    @Published var finished: Bool = false
    
    var isInitilized = false
    
    var title: String {
        isModeCreate ? "New Task" : "Task #\(queryId!)"
    }
    
    var isModeCreate: Bool {
        queryId == nil
    }
    
    var isValidForm: Bool {
        !description.isEmpty
    }
    
    var canFinish: Bool {
        !isModeCreate && !finished &&
            (appState.userId == creatorId || appState.userId == executorId)
    }
    
    var canStartExecute: Bool {
        !canFinish && appState.isExecuter && executorId == nil
    }
    
    init(queryId: Int) {
        self.queryId = queryId
    }
    
    init(longitude: Double, latitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.queryId = nil
    }
    
    func initilize() {
        if isInitilized {
            return
        }
        isInitilized = true
        
        load()
        print("QueryDetailsViewModel initilized")
    }
    
    func createQuery(completion: (Result<Void, Error>) -> Void) {
        if !isValidForm {
            return
        }
        
        queriesRepository.create(
            description: description,
            latitude: latitude,
            longitude: longitude) { result in
            print("complete")
        }
    }
    
    func takeQuery(completion: @escaping () -> Void) {
        guard let queryId = queryId else {
            return
        }
        
        queriesRepository.startExecute(objectiveId: queryId) { result in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func finishQuery(completion: @escaping () -> Void) {
        guard let queryId = queryId else {
            return
        }
        
        queriesRepository.finish(objectiveId: queryId) { result in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func load() {
        guard let queryId = queryId else {
            return
        }
        
        isLoading = true
        
        queriesRepository.get(queryId: queryId) { result in
            switch result {
            case .success(let query):
                self.latitude = query.latitude
                self.longitude = query.longitude
                self.creatorId = query.creatorId
                self.executorId = query.executorId
                self.finished = query.executed
                self.description = query.description
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
