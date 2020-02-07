//
//  Publishable.swift
//  
//
//  Created by Miras Karazhigitov on 2020-02-07.
//

import Foundation

/// Type that would notify observers
public protocol Publishable {
    associatedtype SomeType: AnyObject
    var delegateContainer: DelegateContainer<SomeType> { get }
}

extension Publishable {
    /// Subscribes value to notifications
    public func subscribe(_ value: SomeType) {
        delegateContainer.addObserver(value)
    }
    
    /// Unsubscribes from notifications
    public func unsubscribe(_ value: SomeType) {
        delegateContainer.removeObserver(value)
    }
}
