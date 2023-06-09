import Foundation
import UIKit

struct Job: Hashable, Codable {
    let id: String?
    let positionTitle: String?
    let description: String?
    let company: Company?
    let salaryRange: SalaryRange?
    let location: Int?
    let industry: Int?
    let haveIApplied: Bool?
    
    //----------------------------------------
    // MARK: - Codable protocols
    //----------------------------------------
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case positionTitle
        case description
        case company
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
