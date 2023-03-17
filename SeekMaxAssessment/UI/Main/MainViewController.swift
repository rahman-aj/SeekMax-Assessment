import UIKit

protocol MainViewControllerDelegate: NSObjectProtocol {
  
}

class MainViewController: UIViewController {
    
    //----------------------------------------
    // MARK: - Properties
    //----------------------------------------
    
    static var tabBarHeight: CGFloat = 49
    
    static var safeAreaBottomPadding: CGFloat = 0.0
    
    static var miniPlayerHeightShowingHeight: CGFloat = 0.0
    
    //----------------------------------------
    // MARK: - Lifecycle
    //----------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let window = UIApplication.shared.windows.first
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
        MainViewController.safeAreaBottomPadding = bottomPadding
    }
    
    //----------------------------------------
    // MARK: - View Model
    //----------------------------------------
    
    var viewModel: MainViewModel!
    
    //----------------------------------------
    // MARK: - Delegate
    //----------------------------------------
    
    weak var delegate: MainViewControllerDelegate?
}

//----------------------------------------
// MARK: - UITab Bar Controller Delegate
//----------------------------------------

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

