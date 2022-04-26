

import Foundation

// MARK: - User
struct User: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url, htmlUrl, followersUrl: String
    let followingUrl, gistsUrl, starredUrl: String
    let subscriptionsUrl, organizationsUrl, reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: UserType
    let siteAdmin: Bool

    // Other data
    let name, company: String?
    let blog: String?
    let location: String?
    let email: String?
    //let hireable: ??
    let bio: String?
    let twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int?
    let createdAt, updatedAt: Date?

}

enum UserType: String, Codable {
    case organization = "Organization"
    case user = "User"
}
