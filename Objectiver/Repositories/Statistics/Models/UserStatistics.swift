//
//  File.swift
//  Objectiver
//
//  Created by Борис Вашов on 25.10.2021.
//

import Foundation

struct UserStatistics: Hashable, Decodable {
    var userId: Int
    var place: Int
    var finishedObjectives: Int
    var createdObjectives: Int
    var statisticsType: String
}
