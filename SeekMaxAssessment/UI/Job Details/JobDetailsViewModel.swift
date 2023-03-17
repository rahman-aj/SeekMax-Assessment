import Foundation

class JobDetailsViewModel {
    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------
    
    init(job: Job) {
        self.job = job
    }
    
    //----------------------------------------
    // MARK: - Presentation
    //----------------------------------------
    
    var jobTitle: String? {
        return job.positionTitle
    }
    
    var companyName: String? {
        return job.company?.name
    }
    
    var jobDescription: String? {
        return job.description
    }
    
    var maxSalaryRange: Int {
        return job.salaryRange?.max ?? 0
    }
    
    var minSalaryRange: Int {
        return job.salaryRange?.min ?? 0
    }
    
    var hasApplied: Bool {
        return job.haveIApplied ?? false
    }
    
    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------
    
    private(set) var job: Job!
}
