//
//  RocketCompactCard.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/14/21.
//

import Foundation

struct RocketCompactCard: Codable {
    
    let id: String
    let name: String
    let costPerLaunch: Int
    let successRatePct: Int
    let firstFlight: String
    let flickrImages: [String]?
    var themeImagePath: String? {
        get {
            if let images = flickrImages {
                return images.last!
            }
            return nil
        }
    }

}
