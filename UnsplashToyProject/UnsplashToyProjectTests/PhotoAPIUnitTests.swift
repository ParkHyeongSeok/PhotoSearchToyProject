//
//  PhotoAPIUnitTests.swift
//  UnsplashToyProjectTests
//
//  Created by 박형석 on 2021/12/04.
//

import XCTest
@testable import UnsplashToyProject

class PhotoAPIUnitTests: XCTestCase {
    
    var session: URLSession?
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    override func tearDownWithError() throws {
        session = nil
    }

    // 앱의 networking layer를 구현할 때, 수많은 또 각각이 다른 endpoint들이 존재한다. 그리고 이 endpoint마다 다른 종류이 모델이나 데이터를 반환한다. 하지만 기본 논리를 비슷하다. 그래서 일반적이고 재사용 가능한 네트워킹 로직을 제작해보자.
    
    // 가장 외부의 reponse의 모델을 제네릭을 이용해서 일반적인 형태로 구현
    // 모드 네트워크 요청이 result를 받는 구조라는 것을 전제.
    struct NetworkResponse<Wrapper: Decodable>: Decodable {
        var results: Wrapper
    }
    
    struct Endpoint {
        var path: String
        var queryItems = [URLQueryItem]()
    }
    
    // test

    
    func test_requestPhotosAndDecodeModel() {
        let exp = expectation(description: "urlSession test")
        
        // components.path를 넣어주면 쿼리가 안들어감
        var components = URLComponents(string: "https://api.unsplash.com/search/photos?")
        let clientIDQuery = URLQueryItem(name: "client_id", value: "Qi4G9qPq4OGMycRtl3aHLlZNmCO99slGa3C9MDkj6rU")
        let catQuery = URLQueryItem(name: "query", value: "cat")
        components?.queryItems?.append(clientIDQuery)
        components?.queryItems?.append(catQuery)
        
        guard let url = components?.url else {
            XCTFail("fail to make url")
            return
        }
        
        let task = session?.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                      XCTFail("networking error : status error")
                      return
                  }
            
            if let data = data {
                do {
                    // 들어오는 날짜 : 2021-12-03T07:26:16-05:00
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(NetworkResponse<[Photo]>.self, from: data)
                    print(response.results.first?.timestamp)
                    exp.fulfill()
                } catch let error {
                    XCTFail("networking catch error : \(error)")
                }
                return
            } else {
                XCTFail("networking error : data nil")
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
