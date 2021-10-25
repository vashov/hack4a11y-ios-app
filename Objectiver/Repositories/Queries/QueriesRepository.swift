//
//  QueryRepository.swift
//  Objectiver
//
//  Created by Борис Вашов on 24.10.2021.
//

import Foundation

class QueriesRepository {
    
    @Inject var httpRequestBuilder: HttpRequestBuilder
    
    func create(
        description: String,
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<Void, Error>) -> Void) {

        let urlPath = ApiConstants.apiUri + "objectives/create"
        var request = httpRequestBuilder.buildPost(urlPath)
        
        let json: [String: Any] =
            ["description": description, "latitude": latitude, "longitude": longitude]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
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
            
            completion(.success(Void()))

//            guard let data = data else { return }
//            DispatchQueue.main.async {
//                do {
//                    let token = try JSONDecoder().decode(AuthTokenResult.self, from: data)
//                    completion(.success(token))
//                } catch let error {
//                    print("Error decoding: ", error)
//                    completion(.failure(error))
//                }
//            }
        }

        dataTask.resume()
    }
    
    func startExecute(
        objectiveId: Int,
        completion: @escaping (Result<Void, Error>) -> Void) {

        let urlPath = ApiConstants.apiUri + "objectives/execute"
        var request = httpRequestBuilder.buildPost(urlPath)
        
        let json: [String: Any] = ["objectiveId": objectiveId]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
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
            
            completion(.success(Void()))
        }

        dataTask.resume()
    }
    
    func finish(
        objectiveId: Int,
        completion: @escaping (Result<Void, Error>) -> Void) {

        let urlPath = ApiConstants.apiUri + "objectives/finish"
        var request = httpRequestBuilder.buildPost(urlPath)
        
        let json: [String: Any] = ["objectiveId": objectiveId]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
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
            
            completion(.success(Void()))
        }

        dataTask.resume()
    }
    
    func getAll(completion: @escaping (Result<[Query], Error>) -> Void) {
        let urlPath = ApiConstants.apiUri + "objectives"
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
                    let queries = try JSONDecoder().decode([Query].self, from: data)
                    completion(.success(queries))
                } catch let error {
                    print("Error decoding: ", error)
                    completion(.failure(error))
                }
            }
        }

        dataTask.resume()
    }
    
    func get(queryId: Int, completion: @escaping (Result<Query, Error>) -> Void) {
        let urlPath = ApiConstants.apiUri + "objectives/\(queryId)"
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
                    let query = try JSONDecoder().decode(Query.self, from: data)
                    completion(.success(query))
                } catch let error {
                    print("Error decoding: ", error)
                    completion(.failure(error))
                }
            }
        }

        dataTask.resume()
    }
}
