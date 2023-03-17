import Foundation

class AuthViewModel {
    func loginWithEmail(username: String, password: String) {
        AlamofireClient.shared.userLogin(username: username, password: password)
    }
}
