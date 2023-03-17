import Foundation
import UIKit

struct Jobs: Hashable, Codable {
    let page: Int?
    let size: Int?
    let hasNext: Bool?
    let total: Int?
    let jobs: [Job]?
    
    //----------------------------------------
    // MARK: - Codable protocols
    //----------------------------------------
    
    enum CodingKeys: CodingKey {
        case page
        case size
        case hasNext
        case total
        case jobs
    }
    
    //----------------------------------------
    // MARK: - Hashable protocols
    //----------------------------------------
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(page)
    }
    
    static func == (lhs: Jobs, rhs: Jobs) -> Bool {
        return lhs.page == rhs.page
    }
}
