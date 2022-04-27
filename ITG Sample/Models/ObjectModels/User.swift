//
//  User.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 26/04/2022.
//


import Foundation
import CoreData

// MARK: - User
class User: NSManagedObject, Decodable {
    /*
     let login: String
     let id: Int
     // let nodeId: String
     let avatarUrl: String
     // let gravatarId: String
     // let url, htmlUrl, followersUrl: String
     // let followingUrl, gistsUrl, starredUrl: String
     // let subscriptionsUrl, organizationsUrl, reposUrl: String
     // let eventsUrl: String
     // let receivedEventsUrl: String
     let type: UserType
     // let siteAdmin: Bool
     
     // Other data
     let name, company: String?
     // let blog: String?
     // let location: String?
     // let email: String?
     // let hireable: ??
     // let bio: String?
     // let twitterUsername: String?
     let publicRepos, publicGists, followers, following: Int?
     let createdAt: Date?
     // let updatedAt: Date?
     */
    
     var typeItem: UserType? {
         guard let type = type else { return nil }
         return UserType(rawValue: type)
     }
    
    enum CodingKeys: CodingKey {
        case login, id, avatarUrl, type
        case name, company, publicRepos, publicGists, followers, following, createdAt
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        // TODO: Check if already stored and fetch it
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login       = try container.decode(String.self, forKey: .login)
        self.id          = try container.decode(Int32.self, forKey: .id)
        self.avatarUrl   = try container.decode(String.self, forKey: .avatarUrl)
        self.type        = try container.decode(String.self, forKey: .type)
        
        self.name        = try container.decodeIfPresent(String.self, forKey: .name)
        self.company     = try container.decodeIfPresent(String.self, forKey: .company)
        self.publicRepos = try container.decodeIfPresent(Int32.self, forKey: .publicRepos) ?? 0
        self.publicGists = try container.decodeIfPresent(Int32.self, forKey: .publicGists) ?? 0
        self.followers   = try container.decodeIfPresent(Int32.self, forKey: .followers) ?? 0
        self.following   = try container.decodeIfPresent(Int32.self, forKey: .following) ?? 0
        self.createdAt   = try container.decodeIfPresent(Date.self, forKey: .createdAt)
    
    }


}

enum UserType: String, Decodable {
    case organization = "Organization"
    case user = "User"
}

