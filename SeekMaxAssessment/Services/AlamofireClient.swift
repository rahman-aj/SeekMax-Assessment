import Foundation
import Alamofire

class AlamofireClient {
    // Singleton
    static var shared: AlamofireClient = AlamofireClient()
    
    func fetchJobsList(endPoint: String, results: @escaping (Jobs?) -> Void) {
        guard let url = URL(string: "http://" + AppConstants.apiBaseURL.absoluteString + endPoint) else { return }
        
        AF.request(url).responseDecodable(of: Jobs.self) { response in
            results(response.value)
        }
    }
    
    func userLogin(username: String, password: String) {
        guard let url = URL(string: "http://" + AppConstants.apiBaseURL.absoluteString) else { return }
        // TODO: Create auth api for rest api ( Only graphQL auth is working )
    }
    
    func storeJWTToken(token: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(token)
            UserDefaults.standard.set(data, forKey: "jwt_token")
        } catch {
            print("Error while encoding jwt_token: \(error)")
        }
    }
    
    func getJWTToken() -> String {
        if let jwtTokenData = UserDefaults.standard.data(forKey: "jwt_token") {
            do {
                let decoder = JSONDecoder()
                let jwtToken = try decoder.decode(String.self, from: jwtTokenData)
                return jwtToken
            } catch {
                print("Error while decoding my vehicles ui state: \(error)")
            }
        }
        return ""
    }
    
    func isUserLoggedIn() -> Bool {
        if let _ = UserDefaults.standard.data(forKey: "jwt_token") {
            // Token exists
            return true
        }
        // Token not found
        return false
    }
    
    /// Private initializer.
    private init() {}
}
