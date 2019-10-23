//
//  Publishable.swift
//  
//
//  Created by Miras Karazhigitov on 10/22/19.
//

import Foundation

/// Type that would notify observers
protocol Publishable {
    associatedtype SomeType: AnyObject
    var delegateContainer: DelegateContainer<SomeType> { get }
}

extension Publishable {
    /// Subscribes value to notifications
    func subscribe(_ value: SomeType) {
        delegateContainer.addObserver(value)
    }
    
    /// Unsubscribes from notifications
    func unsubscribe(_ value: SomeType) {
        delegateContainer.removeObserver(value)
    }
}
