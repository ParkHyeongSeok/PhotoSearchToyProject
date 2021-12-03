//
//  Photo.swift
//  UnsplashToyProject
//
//  Created by 박형석 on 2021/12/04.
//

import Foundation

struct Photo: Codable {
    let urls: [[ImageSize:URL]]
    let photographer: Photographer
    
    enum CodingKeys: String, CodingKey {
        case urls
        case photographer = "user"
    }
    
    enum ImageSize: String, Codable {
        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }
}
