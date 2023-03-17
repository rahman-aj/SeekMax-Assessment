import Foundation
import UIKit

struct SalaryRange: Hashable, Codable {
    let min: Int?
    let max: Int?
    
    //----------------------------------------
    // MARK: - Codable protocols
    //----------------------------------------
    
    enum CodingKeys: CodingKey {
        case min
        case max
    }
    
    //----------------------------------------
    // MARK: - Hashable protocols
    //----------------------------------------
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(max)
    }
    
    static func == (lhs: SalaryRange, rhs: SalaryRange) -> Bool {
        return lhs.max == rhs.max
    }
}
