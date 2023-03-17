import UIKit

class JobCardCollectionViewCell: UICollectionViewCell, NibReusable {
    
    func bindViewModel(viewModel: JobCardCollectionViewCellViewModel) {
        self.viewModel = viewModel
        
        jobTitleLabel.text = viewModel.jobTitle
        companyNameLabel.text = viewModel.companyName
        jobDescriptionLabel.text = viewModel.jobDescription
    }
    
    var viewModel: JobCardCollectionViewCellViewModel?
    
    @IBOutlet private weak var jobTitleLabel: UILabel!
    
    @IBOutlet private weak var companyNameLabel: UILabel!
    
    @IBOutlet private weak var jobDescriptionLabel: UILabel!
}
