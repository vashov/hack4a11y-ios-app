//
//  Container.swift
//  Objectiver
//
//  Created by Борис Вашов on 18.10.2021.
//

import Foundation
 import Swinject

 class Resolver {
    static let shared = Resolver()

    private let container: Container = {
        let container = Container()

        container.register(AuthRepository.self) { _ in AuthRepository() }
        container.register(UsersRepository.self) { _ in UsersRepository() }
        container.register(StatisticsRepository.self) { _ in StatisticsRepository() }
        container.register(QueriesRepository.self) { _ in QueriesRepository() }
        
        container.register(AppState.self) { _ in AppState() }
            .inObjectScope(ObjectScope.container)
        
        container.register(HttpRequestBuilder.self) { _ in HttpRequestBuilder() }
        
        return container
    }()

    func resolve<T>(_ type: T.Type) -> T {
        let service = container.resolve(T.self)
        
        if service == nil {
            print("Unresolved ", T.self)
        }
        
        return service!
    }
 }
