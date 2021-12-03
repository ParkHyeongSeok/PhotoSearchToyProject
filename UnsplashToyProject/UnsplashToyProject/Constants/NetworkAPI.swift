//
//  NetworkAPI.swift
//  UnsplashToyProject
//
//  Created by 박형석 on 2021/12/04.
//

import Foundation

enum PhotoAPI {
    static let BASE_URL = "https://api.unsplash.com/"
}

enum APIError: LocalizedError {
    case unknownError
}
