//
//  CoreData+Extensions.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import Foundation


/// Decoder Configuration Error
enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

/// Coding User Info Key
extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

