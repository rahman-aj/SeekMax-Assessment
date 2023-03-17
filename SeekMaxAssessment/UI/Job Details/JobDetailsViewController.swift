import UIKit

class JobDetailsViewController: UIViewController {
    class func fromStoryboard() -> JobDetailsViewController {
        let navigationController = StoryboardScene.JobDetails.initialScene.instantiate()
        let viewController = navigationController.viewControllers[0] as! JobDetailsViewController
        return viewController
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
        jobTitleLabel.text = viewModel.jobTitle
        companyNameLabel.text = viewModel.companyName
        salaryRangeLabel.text = "Salary Range: \(String(describing: viewModel.minSalaryRange)) - \(String(describing: viewModel.maxSalaryRange))"
        jobDescriptionLabel.text = viewModel.jobDescription
        hasAppliedLabel.isHidden = !viewModel.hasApplied
    }
    
    //----------------------------------------
    // MARK: - Actions
    //----------------------------------------
    
    @IBAction private func applyButtonDidTap(sender: UIButton!) {
        
    }
    
    @IBAction private func dismissButtonDidTap(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //----------------------------------------
    // MARK: - View Model
    //----------------------------------------
    
    var viewModel: JobDetailsViewModel!
    
    //----------------------------------------
    // MARK: - Outlets
    //----------------------------------------
    
    @IBOutlet private weak var jobTitleLabel: UILabel!
    
    @IBOutlet private weak var companyNameLabel: UILabel!
    
    @IBOutlet private weak var salaryRangeLabel: UILabel!
    
    @IBOutlet private weak var jobDescriptionLabel: UILabel!
    
    @IBOutlet private weak var hasAppliedLabel: UILabel!
}
