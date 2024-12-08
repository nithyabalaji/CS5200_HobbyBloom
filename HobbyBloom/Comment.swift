//
//  Comment.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 12/3/24.
//

import Foundation
import FirebaseCore
struct Comment: Codable {
    let email: String
    let text: String
    let time: Timestamp
}

