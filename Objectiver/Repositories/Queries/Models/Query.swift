//
//  Query.swift
//  Objectiver
//
//  Created by Борис Вашов on 25.10.2021.
//

import Foundation

struct Query: Identifiable, Decodable {
    var id: Int
    var description: String
    var latitude: Double
    var longitude: Double
    
    var createdAt: String
    var creatorId: Int
    var executorId: Int?
    var executed: Bool
    var executedAt: String?
    var updatedAt: String?
}
