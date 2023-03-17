import Foundation
import UIKit

protocol AuthCoodinatorDelegate: NSObjectProtocol {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator)
}

class AuthCoordinator: NSObject {
    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------
    
    init(authViewController: AuthViewController) {
        self.authViewController = authViewController
    }
    
    //----------------------------------------
    // MARK: - Starting Flows
    //----------------------------------------
    
    func start() {
        authViewController.delegate = self
    }
    
    //----------------------------------------
    // MARK: - Delegate
    //----------------------------------------
    
    weak var delegate: AuthCoodinatorDelegate?
    
    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------
        
    private let authViewController: AuthViewController
}

//----------------------------------------
// MARK: - Auth View Controller Delegate
//----------------------------------------

extension AuthCoordinator: AuthViewControllerDelegate {
    func authViewControllerDidFinish(_ viewController: AuthViewController) {
        if authViewController.navigationController?.presentingViewController != nil {
            authViewController.dismiss(animated: true)
        }
        delegate?.authCoordinatorDidFinish(self)
    }
    
    func authViewControllerDidFinishGuestMode(_ viewController: AuthViewController) {
        if authViewController.navigationController?.presentingViewController == nil {
            delegate?.authCoordinatorDidFinish(self)
        } else {
            authViewController.dismiss(animated: true)
        }
    }
    
    func authViewControllerDidCancel(_ viewController: AuthViewController) {
        viewController.dismiss(animated: true)
    }
}
