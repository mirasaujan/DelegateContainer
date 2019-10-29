public struct Observation<Observer: AnyObject> {
    weak var observer: Observer?
}

public protocol DelegateContainer: AnyObject {
    associatedtype Observer: AnyObject
    var observations: [ObjectIdentifier : Observation<Observer>] { get set }
}

public extension DelegateContainer {
    /// Gets all observers, while removing deinit-ed objects behind the scences
    var observers: [Observer] {
        var relevantObservations = [Observer]()
        for (id, observation) in observations {
            guard let observer = observation.observer else {
                observations.removeValue(forKey: id)
                continue
            }
            
            relevantObservations.append(observer)
        }
        
        return relevantObservations
    }
    
    
    /// Perform operation on each observer
    /// - Parameter block: block to perform on each operation
    func perform(_ block: (Observer) -> Void) {
        for observer in observers {
            block(observer)
        }
    }
    
    /// Adds observer
    /// - Parameter observer: observer to add
    func addObserver(_ observer: Observer) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }
    
    /// Removes observer
    /// - Parameter observer: observer to remove
    func removeObserver(_ observer: Observer) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
}
