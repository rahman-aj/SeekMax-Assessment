import Foundation
import Combine

class HomeViewModel {
    
    //----------------------------------------
    // MARK: - Load Data
    //----------------------------------------
    
    func fetchJobs() {
        AlamofireClient.shared.fetchJobsList(endPoint: "jobs/published") { jobs in
            self.jobsSubject.send(jobs)
        }
    }
    
    //----------------------------------------
    // MARK: - Publishers
    //----------------------------------------
    
    let jobsSubject = CurrentValueSubject<Jobs?, Never>(nil)
}
