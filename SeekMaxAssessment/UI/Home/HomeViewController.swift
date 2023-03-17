import UIKit

protocol HomeViewControllerDelegate: NSObjectProtocol {
    
}

class HomeViewController: UIViewController {
    //----------------------------------------
    // MARK: - Lifecycle
    //----------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //----------------------------------------
    // MARK: - View model
    //----------------------------------------

    var viewModel: HomeViewModel!

    //----------------------------------------
    // MARK: - Delegate
    //----------------------------------------

    weak var delegate: HomeViewControllerDelegate?
}
