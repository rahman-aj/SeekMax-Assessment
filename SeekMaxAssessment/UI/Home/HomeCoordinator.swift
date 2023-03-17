import Foundation

protocol HomeCoordinatorDelegate: NSObjectProtocol {
    
}

class HomeCoordinator: NSObject {
    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------
    
    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }
    
    //----------------------------------------
    // MARK: - Starting flows
    //----------------------------------------
    
    func start() {
        self.homeViewController.delegate = self
    }
    
    //----------------------------------------
    // MARK: - Delegate
    //----------------------------------------
    
    weak var delegate: HomeCoordinatorDelegate?
    
    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------
    
    private let homeViewController: HomeViewController
}


//----------------------------------------
// MARK: - Home view controller delegate
//----------------------------------------

extension HomeCoordinator: HomeViewControllerDelegate {
  
}
