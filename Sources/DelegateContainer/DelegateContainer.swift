open class DelegateContainer<T: AnyObject> {
    /// Wrapper around observer
    struct Observation {
        weak var observer: T?
    }
    
    private var observations = [ObjectIdentifier : Observation]()
    
    /// Gets all observers, while removing deinit-ed objects behind the scences
    var observers: [T] {
        var relevantObservations = [T]()
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
    func perform(_ block: (T) -> Void) {
        for observer in observers {
            block(observer)
        }
    }
    
    /// Adds observer
    /// - Parameter observer: observer to add
    func addObserver(_ observer: T) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }
    
    /// Removes observer
    /// - Parameter observer: observer to remove
    func removeObserver(_ observer: T) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
}
