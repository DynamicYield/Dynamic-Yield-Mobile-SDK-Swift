import Foundation
public struct NewsletterSubscriptionEventProperties: EventProperties {

    public var dyType: String
    var cuidType: String?
    var cuid: String?
    var secondaryIdentifiers: [SecondaryIdentifier]?

    public init(cuidType: String? = nil, cuid: String? = nil, secondaryIdentifiers: [SecondaryIdentifier]? = nil) {
        self.dyType = "newsletter-subscription-v1"
        self.cuidType = cuidType
        self.cuid = cuid
        self.secondaryIdentifiers = secondaryIdentifiers
    }
}
