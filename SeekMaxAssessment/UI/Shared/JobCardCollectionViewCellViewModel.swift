import Foundation

class JobCardCollectionViewCellViewModel {
    init(job: Job?) {
        self.job = job
    }
    
    var jobTitle: String? {
        return job?.positionTitle
    }
    
    var companyName: String {
        return "Company Name"
    }
    
    var jobDescription: String? {
        return job?.description
    }
    
    private(set) var job: Job?
}
