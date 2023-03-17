import UIKit
import Combine

protocol HomeViewControllerDelegate: NSObjectProtocol {
    func homeViewControllerDidSelectContent(_ viewController: HomeViewController, job: Job)
}

class HomeViewController: UIViewController {
    //----------------------------------------
    // MARK: - Lifecycle
    //----------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        viewModel.fetchJobs()
        viewModel.jobsSubject
            .sink { [weak self] jobs in
                guard let self = self else { return }
                
                self.jobs = jobs
                self.collectionView.reloadData()
            }.store(in: &cancellables)
    }
    
    //----------------------------------------
    // MARK: - Configure Views
    //----------------------------------------
    
    private func configureViews() {
        collectionView.register(cellType: JobCardCollectionViewCell.self)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //----------------------------------------
    // MARK: - View model
    //----------------------------------------

    var viewModel: HomeViewModel!

    //----------------------------------------
    // MARK: - Delegate
    //----------------------------------------

    weak var delegate: HomeViewControllerDelegate?
    
    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------
    
    private var cancellables: Set<AnyCancellable> = Set()
    
    private var jobs: Jobs?
    
    //----------------------------------------
    // MARK: - Outlets
    //----------------------------------------
    
    @IBOutlet private weak var collectionView: UICollectionView!
}

//----------------------------------------
// MARK: - UI Collection View Delegate
//----------------------------------------

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let job = jobs?.jobs?[indexPath.item] else { return }
        delegate?.homeViewControllerDidSelectContent(self, job: job)
    }
}

//--------------------------------------------------
// MARK: - UI Collection View Delegate Flow Layout
//--------------------------------------------------

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: -16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

//----------------------------------------
// MARK: - UI Collection View Data Source
//----------------------------------------

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs?.size ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobCardCollectionViewCell.reuseIdentifier, for: indexPath) as! JobCardCollectionViewCell
        
        let viewModel = JobCardCollectionViewCellViewModel(job: jobs?.jobs?[indexPath.item])
        cell.bindViewModel(viewModel: viewModel)
        
        return cell
    }
}
