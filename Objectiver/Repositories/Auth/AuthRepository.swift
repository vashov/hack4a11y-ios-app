//
//  AuthRepository.swift
//  Objectiver
//
//  Created by Борис Вашов on 16.10.2021.
//

import Foundation

class AuthRepository {
    
    @Inject var httpRequestBuilder: HttpRequestBuilder
    
//    let session: URLSession
//    let baseUrl: String
//    let bgQueue = DispatchQueue(label: "bg_parse_queue")
//
//    init(session: URLSession, baseUrl: String) {
//        self.session = session
//        self.baseUrl = baseUrl
//    }
    
    func register(_ login: String, _ password: String, _ role: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let urlPath = ApiConstants.apiUri + "auth/register"
        var request = httpRequestBuilder.buildPost(urlPath)
        
        let json: [String: Any] = ["login": login, "password": password, "role": role]
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
                let msg = String(bytes: data!, encoding: .utf8)
                print("statusCode", response.statusCode, msg!)
                completion(.success(false))
//                DispatchQueue.main.async {
//                let msg = try JSONDecoder().decode(String.self, from: data)
//                print("statusCode", response.statusCode, msg)
//                completion(.success(false))
                return
            }

            completion(.success(true))

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

    func login(_ login: String, _ password: String, completion: @escaping (Result<AuthTokenResult, Error>) -> Void) {
        let urlPath = ApiConstants.apiUri + "auth/token"
        var request = httpRequestBuilder.buildPost(urlPath)
        
        let json: [String: Any] = ["login": login, "password": password]
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

            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let token = try JSONDecoder().decode(AuthTokenResult.self, from: data)
                    completion(.success(token))
                } catch let error {
                    print("Error decoding: ", error)
                    completion(.failure(error))
                }
            }
        }

        dataTask.resume()
    }
}
