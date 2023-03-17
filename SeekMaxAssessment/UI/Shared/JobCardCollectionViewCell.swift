import UIKit

class JobCardCollectionViewCell: UICollectionViewCell, NibReusable {
    
    //----------------------------------------
    // MARK: - Bind View Model
    //----------------------------------------
    
    func bindViewModel(viewModel: JobCardCollectionViewCellViewModel) {
        self.viewModel = viewModel
        
        jobTitleLabel.text = viewModel.jobTitle
        companyNameLabel.text = viewModel.companyName
        jobDescriptionLabel.text = viewModel.jobDescription
    }
    
    //----------------------------------------
    // MARK: - View Model
    //----------------------------------------
    
    var viewModel: JobCardCollectionViewCellViewModel?
    
    //----------------------------------------
    // MARK: - Outlets
    //----------------------------------------
    
    @IBOutlet private weak var jobTitleLabel: UILabel!
    
    @IBOutlet private weak var companyNameLabel: UILabel!
    
    @IBOutlet private weak var jobDescriptionLabel: UILabel!
}
