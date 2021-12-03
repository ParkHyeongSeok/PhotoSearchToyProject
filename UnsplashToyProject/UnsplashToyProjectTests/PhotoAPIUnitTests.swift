//
//  PhotoAPIUnitTests.swift
//  UnsplashToyProjectTests
//
//  Created by 박형석 on 2021/12/04.
//

import XCTest
@testable import UnsplashToyProject

class PhotoAPIUnitTests: XCTestCase {
    
    var urlSession: URLSession?
    
    override func setUpWithError() throws {
        urlSession = URLSession.shared
    }
    
    override func tearDownWithError() throws {
        urlSession = nil
    }

    // 앱의 networking layer를 구현할 때, 수많은 또 각각이 다른 endpoint들이 존재한다. 그리고 이 endpoint마다 다른 종류이 모델이나 데이터를 반환한다. 하지만 기본 논리를 비슷하다. 그래서 일반적이고 재사용 가능한 네트워킹 로직을 제작해보자.
    
    // 가장 외부의 reponse의 모델을 제네릭을 이용해서 일반적인 형태로 구현
    // 모드 네트워크 요청이 result를 받는 구조라는 것을 전제.
    struct NetworkResponse<Wrapper: Decodable>: Decodable {
        var result: Wrapper
    }
    
    struct Endpoint {
        var path: String
        var queryItems = [URLQueryItem]()
    }
    
    func test_requestPhotos() {
        let exp = expectation(description: "urlSession test")
        
        let baseURL = PhotoAPI.BASE_URL
        let endPoint = "/search/photos/cat"
        
        guard let url = URL(string: baseURL + endPoint) else {
            XCTFail("fail to make url")
            return
        }
        
        let task = urlSession?.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                      XCTFail("networking error")
                      return
                  }
            
            if let data = data {
                do {
                    let nsResponse = try JSONDecoder().decode(NetworkResponse<[Photo]>.self, from: data)
                    print(nsResponse.result[0].photographer.name)
                    exp.fulfill()
                } catch let error {
                    XCTFail("networking error : \(error)")
                }
                return
            } else {
                XCTFail("networking error : \(error)")
            }
        }
        
        task?.resume()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print(error)
            } else {
                print("success")
            }
        }
        
    }

}
