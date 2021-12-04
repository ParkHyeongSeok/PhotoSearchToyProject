//
//  Photographer.swift
//  UnsplashToyProject
//
//  Created by 박형석 on 2021/12/04.
//

import Foundation
import UIKit

struct Photographer: Codable {
    let name: String
    let image: ProfileImageURL
    
    enum CodingKeys: String, CodingKey {
        case name
        case image = "profile_image"
    }
}

struct ProfileImageURL: Codable {
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case url = "medium"
    }
}
