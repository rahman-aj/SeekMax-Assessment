import Foundation
import UIKit

struct Job: Hashable, Codable {
    let id: String?
    let positionTitle: String?
    let description: String?
    let salaryRange: SalaryRange?
    let location: Int?
    let industry: Int?
    let haveIApplied: Bool?
    
    //----------------------------------------
    // MARK: - Codable protocols
    //----------------------------------------
    
    enum CodingKeys: CodingKey {
        case id
        case positionTitle
        case description
        case salaryRange
        case location
        case industry
        case haveIApplied
    }
    
    //----------------------------------------
    // MARK: - Hashable protocols
    //----------------------------------------
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Job, rhs: Job) -> Bool {
        return lhs.id == rhs.id
    }
}
