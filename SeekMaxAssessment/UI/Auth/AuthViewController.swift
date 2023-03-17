import Foundation
import UIKit
import Combine

protocol AuthViewControllerDelegate: NSObjectProtocol {    
    func authViewControllerDidFinish(_ viewController: AuthViewController)
    
    func authViewControllerDidFinishGuestMode(_ viewController: AuthViewController)
    
    func authViewControllerDidCancel(_ viewController: AuthViewController)
}

class AuthViewController: UIViewController {
    class func fromStoryboard() -> (UINavigationController, AuthViewController) {
        let navigationController = StoryboardScene.Auth.initialScene.instantiate()
        let viewController = navigationController.viewControllers[0] as! AuthViewController
        return (navigationController, viewController)
    }
    
    //----------------------------------------
    // MARK: - Lifecycle
    //----------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    //----------------------------------------
    // MARK: - Configure Views
    //----------------------------------------
    
    private func configureViews() {
        hideKeyboardWhenTappedAround()
    }
    
    //----------------------------------------
    // MARK: - Email Authorization
    //----------------------------------------
    
    private func loginWithEmail() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        viewModel.loginWithEmail(username: email, password: password)
    }
    
    //----------------------------------------
    // MARK: - Actions
    //----------------------------------------
    
    @IBAction private func loginButtonDidTap(_ sender: UIButton) {
        loginWithEmail()
    }
    
    @IBAction private func continueAsGuestButtonDidTap(_ sender: UIButton) {
        delegate?.authViewControllerDidFinish(self)
    }
    
    @IBAction private func cancelLoginButtonDidTap(_ sender: UIButton) {
        delegate?.authViewControllerDidCancel(self)
    }
    
    //----------------------------------------
    // MARK: - Delegate
    //----------------------------------------
    
    weak var delegate: AuthViewControllerDelegate?
    
    //----------------------------------------
    // MARK: - View Model
    //----------------------------------------
    
    var viewModel: AuthViewModel!
    
    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------
    
    private var cancellables = Set<AnyCancellable>()
    
    //----------------------------------------
    // MARK: - Outlets
    //----------------------------------------
    
    @IBOutlet private var emailTextField: UITextField!
    
    @IBOutlet private var passwordTextField: UITextField!
            
    @IBOutlet private var loginButton: UIButton!
}

//----------------------------------------
// MARK: - UITextField Delegate
//----------------------------------------

extension AuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
