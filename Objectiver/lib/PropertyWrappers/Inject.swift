//
//  Inject.swift
//  Objectiver
//
//  Created by Борис Вашов on 18.10.2021.
//

import Foundation

 @propertyWrapper
 struct Inject<Component> {
    let wrappedValue: Component
    init() {
        self.wrappedValue = Resolver.shared.resolve(Component.self)
    }
 }
