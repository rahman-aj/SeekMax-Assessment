import UIKit

protocol HomeViewControllerDelegate: NSObjectProtocol {
    
}

class HomeViewController: UIViewController {
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
    // MARK: - Outlets
    //----------------------------------------
    
    @IBOutlet private weak var collectionView: UICollectionView!
}

//----------------------------------------
// MARK: - UI Collection View Delegate
//----------------------------------------

extension HomeViewController: UICollectionViewDelegate {
    
}

//--------------------------------------------------
// MARK: - UI Collection View Delegate Flow Layout
//--------------------------------------------------

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}

//----------------------------------------
// MARK: - UI Collection View Data Source
//----------------------------------------

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JobCardCollectionViewCell.reuseIdentifier, for: indexPath) as! JobCardCollectionViewCell
        return cell
    }
}
