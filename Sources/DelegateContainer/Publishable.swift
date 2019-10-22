//
//  Publishable.swift
//  
//
//  Created by Miras Karazhigitov on 10/22/19.
//

import Foundation

protocol Publishable {
    associatedtype SomeType: AnyObject
    var delegateContainer: DelegateContainer<SomeType> { get }
    
    func subscribe(_ value: SomeType)
    func unsubscribe(_ value: SomeType)
}

extension Publishable {
    func subscribe(_ value: SomeType) {
        delegateContainer.addObserver(value)
    }
    
    func unsubscribe(_ value: SomeType) {
        delegateContainer.removeObserver(value)
    }
}
