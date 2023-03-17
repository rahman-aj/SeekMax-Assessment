import Foundation

protocol HomeCoordinatorDelegate: NSObjectProtocol {
    func homeCoordinatorDidSelectContent(_ homeCoordinator: HomeCoordinator, job: Job)
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
    func homeViewControllerDidSelectContent(_ viewController: HomeViewController, job: Job) {
        delegate?.homeCoordinatorDidSelectContent(self, job: job)
    }
}
