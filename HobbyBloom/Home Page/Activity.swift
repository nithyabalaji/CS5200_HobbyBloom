//
//  Activity.swift
//  HobbyBloom
//
//  Created by Dina Barua on 12/5/24.
//

import Foundation
import FirebaseFirestore

struct Activity: Decodable {
    let id: String
    let name: String
    let city: String
    let description: String
    let price: String
    let interest_tags: [String]
    let personality_tags: [String]
    let photo_url: String? // Optional in case it's missing
    let date: Timestamp // Use Timestamp to match Firestore's type
    // Computed property to convert Timestamp to DateComponents
    var dateComponents: DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.year, .month, .day], from: date.dateValue())
    }
    // Optional: Add a formatted date string for UI
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date.dateValue())
    }
}
