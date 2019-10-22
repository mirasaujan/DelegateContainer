class DelegateObserver<T: AnyObject> {
    private var observations = [ObjectIdentifier : Observation]()
    
    struct Observation {
        weak var observer: T?
    }
    
    var observers: [T?] {
        var relevantObservations = [T?]()
        for (id, observation) in observations {
            
            guard observation.observer != nil else {
                observations.removeValue(forKey: id)
                continue
            }
            
            relevantObservations.append(observation.observer)
        }
        
        return relevantObservations
    }
    
    func perform(_ block: (T?) -> Void) {
        for observer in observers {
            block(observer)
        }
    }
    
    func addObserver(_ observer: T) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }
    
    func removeObserver(_ observer: T) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
}
