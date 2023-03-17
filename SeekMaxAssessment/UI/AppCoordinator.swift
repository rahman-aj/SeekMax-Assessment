import UIKit

class AppCoordinator: NSObject {
    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------
    
    init(mainViewController: MainViewController) {
        self.mainViewController = mainViewController
        
        super.init()
        
        mainViewController.delegate = self
        mainViewController.viewModel = MainViewModel()
    }
    
    //----------------------------------------
    // MARK: - Starting Flows
    //----------------------------------------
    
    func start(transitionStyle: TransitionStyle = .push) {
        startMainFlow()
    }
    
    private func restart() {
        // If the active view controller is in the midst of presenting another view controller, we have to perform and
        // complete dismissal before we can restart the app's normal flow.
        if let activeViewController = activeViewController, activeViewController.presentedViewController != nil {
            activeViewController.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.start(transitionStyle: .crossDissolve)
            }
        } else {
            start(transitionStyle: .crossDissolve)
        }
    }
    
    //----------------------------------------
    // MARK: - Main Flow
    //----------------------------------------
    
    private func startMainFlow(transitionStyle: TransitionStyle = .push) {
        // Load main tab view controller.
        let mainTabBarController = StoryboardScene.Main.tabBarController.instantiate()
        mainTabBarController.delegate = mainViewController
        
        if let activeViewController = activeViewController {
            mainViewController.transition(from: activeViewController,
                                          to: mainTabBarController,
                                          transitionStyle: transitionStyle)
        } else {
            mainViewController.addChild(mainTabBarController)
            mainViewController.view.addSubview(mainTabBarController.view)
            NSLayoutConstraint.activate(mainTabBarController.view.constraints(pinningEdgesTo: mainViewController.view))
            MainViewController.tabBarHeight = mainTabBarController.tabBar.frame.height
            mainTabBarController.didMove(toParent: mainViewController)
        }
        
        activeViewController = mainTabBarController
        
        let homeNavigationController = mainTabBarController.viewControllers![0] as! UINavigationController
        let homeViewController = homeNavigationController.topViewController as! HomeViewController
        homeViewController.viewModel = HomeViewModel()
        let homeCoordinator = HomeCoordinator(homeViewController: homeViewController)
        homeCoordinator.delegate = self
        self.homeCoordinator = homeCoordinator
        homeCoordinator.start()
    }
    
    //----------------------------------------
    // MARK: - Presentation
    //----------------------------------------
    
    private func pushViewController(viewController: UIViewController,
                                    navigationStyle: NavigationStyle = .push,
                                    animated: Bool = true) {
        if let mainTabBarController = activeViewController as? UITabBarController {
            if let presentedViewController = mainTabBarController.presentedViewController,
               var activeNavigationController = presentedViewController as? UINavigationController {
                // Push in Modal
                // Find the top most layer UINavigationController for push
                while let presentedViewController = activeNavigationController.presentedViewController as? UINavigationController {
                    activeNavigationController = presentedViewController
                }
                
                switch navigationStyle {
                case .push:
                    activeNavigationController.pushViewController(viewController, animated: animated)
                    
                case .present:
                    activeNavigationController.present(viewController, animated: animated)
                }
            } else if var activeNavigationController = mainTabBarController.viewControllers?[mainTabBarController.selectedIndex] as? UINavigationController {
                // Find the top most layer UINavigationController for push
                while let presentedViewController = activeNavigationController.presentedViewController as? UINavigationController {
                    activeNavigationController = presentedViewController
                }
                
                switch navigationStyle {
                case .push:
                    activeNavigationController.pushViewController(viewController, animated: animated)
                    
                case .present:
                    activeNavigationController.present(viewController, animated: animated)
                }
            }
        } else {
            switch navigationStyle {
            case .push:
                self.mainViewController.navigationController?.pushViewController(viewController, animated: animated)
                
            case .present:
                self.mainViewController.navigationController?.present(viewController, animated: animated)
            }
        }
    }
    
    //----------------------------------------
    // MARK: - Actions
    //----------------------------------------
    
    func showJobDetailsViewController(job: Job) {
        let viewController = JobDetailsViewController.fromStoryboard()
        viewController.viewModel = JobDetailsViewModel(job: job)
        pushViewController(viewController: viewController, navigationStyle: .push)
    }
    
    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------
    
    // Managed view controllers
    private let mainViewController: MainViewController
    
    // View controllers that are hosted in the main view controller
    private var activeViewController: UIViewController?
    
    // Child coordinators
    private var homeCoordinator: HomeCoordinator?
}

//----------------------------------------
// MARK: - Main View Controller Delegate
//----------------------------------------

extension AppCoordinator: MainViewControllerDelegate {
    
}

//----------------------------------------
// MARK: - Home View Controller Delegate
//----------------------------------------

extension AppCoordinator: HomeCoordinatorDelegate {
    func homeCoordinatorDidSelectContent(_ homeCoordinator: HomeCoordinator, job: Job) {
        showJobDetailsViewController(job: job)
    }
}
