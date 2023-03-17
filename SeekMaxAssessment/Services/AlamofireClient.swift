import Foundation
import Alamofire

class AlamofireClient {
    // Singleton
    static var shared: AlamofireClient = AlamofireClient()
    
    func fetchJobsList(endPoint: String, results: @escaping (Jobs?) -> Void) {
        guard let url = URL(string: "http://" + AppConstants.apiBaseURL.absoluteString + endPoint) else { return }

        AF.request(url).responseDecodable(of: Jobs.self) { response in
            print("This is response \(response)")
            results(response.value)
        }
    }
    
    /// Private initializer.
    private init() {}
}
