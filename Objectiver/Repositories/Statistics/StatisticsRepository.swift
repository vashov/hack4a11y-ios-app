//
//  StatisticsRepository.swift
//  Objectiver
//
//  Created by Борис Вашов on 18.10.2021.
//

import Foundation

class StatisticsRepository {
    
    @Inject var httpRequestBuilder: HttpRequestBuilder
    
    func getTop(completion: @escaping (Result<[UserStatistics], Error>) -> Void) {
        let urlPath = ApiConstants.apiUri + "statistics/top"
        let request = httpRequestBuilder.buildGet(urlPath)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode != 200 {
                let msg = "statusCode" + String(response.statusCode)
                print(msg)
                completion(.failure(ApiCodeError(description: msg)))
                return
            }

            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let usersStatistics = try JSONDecoder().decode([UserStatistics].self, from: data)
                    completion(.success(usersStatistics))
                } catch let error {
                    print("Error decoding: ", error)
                    completion(.failure(error))
                }
            }
        }

        dataTask.resume()
    }
    
    func getUserStatistics(userId: Int, completion: @escaping (Result<UserStatistics, Error>) -> Void) {
        let urlPath = ApiConstants.apiUri + "statistics/\(userId)"
        let request = httpRequestBuilder.buildGet(urlPath)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode != 200 {
                let msg = "statusCode" + String(response.statusCode)
                print(msg)
                completion(.failure(ApiCodeError(description: msg)))
                return
            }

            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let userStatistics = try JSONDecoder().decode(UserStatistics.self, from: data)
                    completion(.success(userStatistics))
                } catch let error {
                    print("Error decoding: ", error)
                    completion(.failure(error))
                }
            }
        }

        dataTask.resume()
    }
}
