import Foundation
import UIKit

struct Company: Hashable, Codable {
    let id: String?
    let name: String?
    let createdAt: String?
    let updatedAt: String?
    
    //----------------------------------------
    // MARK: - Codable protocols
    //----------------------------------------
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case createdAt
        case updatedAt
    }
    
    //----------------------------------------
    // MARK: - Hashable protocols
    //----------------------------------------
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Company, rhs: Company) -> Bool {
        return lhs.id == rhs.id
    }
}
