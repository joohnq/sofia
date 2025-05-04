import Foundation
import FirebaseFirestore

struct Artifact: Identifiable, Hashable, Codable {
    @DocumentID public var id: String?
    public var title: String
    public var author: String?
    public var url: String

    public var excerpt: String?
    public var notes: String?
    public var readingTime: Int?
    public var imageUrl: String?
    public var siteName: String?

    public var isRead: Bool = false
    public var isFlagged: Bool = false

    public var readableHTML: String?
    public var fullText: String?

    public var userId: String?
    public var createdAt: Date = Date()
    public var lastUpdatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case url

        case excerpt
        case notes
        case readingTime
        case imageUrl
        case siteName

        case isRead
        case isFlagged

        case readableHTML
        case fullText

        case userId
        case createdAt
        case lastUpdatedAt
    }
}
