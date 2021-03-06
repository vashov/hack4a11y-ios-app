//
//  QueryPlace.swift
//  Objectiver
//
//  Created by Борис Вашов on 25.10.2021.
//

import Foundation
import MapKit

struct QueryPlace: Identifiable {
    let id = UUID()
    let queryId: Int
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      }
}
