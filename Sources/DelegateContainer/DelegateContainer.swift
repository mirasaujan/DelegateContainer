open class DelegateContainer<T: AnyObject> {
    /// Wrapper around observer
    struct Observation {
        weak var observer: T?
    }
    
    private var observations = [ObjectIdentifier : Observation]()
    
    public init() {}
    
    var observers: [T?] {
        observations.values.map { $0.observer }
    }
    
    /// Perform operation on each observer
    /// - Parameter block: block to perform on each operation
    func perform(_ block: (T) -> Void) {
        for (id, observation) in observations {
            guard let observer = observation.observer else {
                observations.removeValue(forKey: id)
                continue
            }

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
