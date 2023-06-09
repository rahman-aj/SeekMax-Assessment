import Foundation

class JobCardCollectionViewCellViewModel {
    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------
    
    init(job: Job?) {
        self.job = job
    }
    
    //----------------------------------------
    // MARK: - Presentation
    //----------------------------------------
    
    var jobTitle: String? {
        return job?.positionTitle
    }
    
    var companyName: String? {
        return job?.company?.name
    }
    
    var jobDescription: String? {
        return job?.description
    }
    
    var hasApplied: Bool? {
        return job?.haveIApplied
    }
    
    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------
    
    private(set) var job: Job?
}
