import Foundation

struct Environment {
    // Singleton
    static var shared: Environment = Environment()
    
    let apiBaseURL: URL = {
        if let url = ProcessInfo().environment["API_BASE_URL"] {
            return URL(string: url)!
        }
        
        if let url = Bundle.main.infoDictionary?["API_BASE_URL"] as? String {
            return URL(string: url)!
        }
        
        fatalError("API_BASE_URL was not defined in the main bundle or as an environment variable")
    }()
    
    /// Private initializer.
    private init() {}
}
