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
    let images: [[ImageSize:URL]]
    
    enum CodingKeys: String, CodingKey {
        case name
        case images = "profile_image"
    }
    
    enum ImageSize: String, Codable {
        case small = "small"
        case medium = "medium"
        case large = "large"
    }
    
    subscript(of size: ImageSize) -> URL? {
        switch size {
        case .small:
            return self.images[0][.small]
        case .medium:
            return self.images[1][.medium]
        case .large:
            return self.images[2][.large]
        }
    }
}
