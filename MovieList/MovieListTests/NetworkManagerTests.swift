//
//  NetworkManagerTests.swift
//  MovieListTests
//
//  Created by Nithin Kumar on 02/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import XCTest
import Mockingjay

@testable import MovieList
class NetworkManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessOrFailure() {
        let request = URLRequest(url: URL(string: "http://test.com/")!)
        let error = NSError(domain: "MovieTests", code: 0, userInfo: nil)
        let response = failure(error)(request)
        XCTAssertEqual(response, Response.failure(error))
        
        NetworkManager().makeDataRequest(withUrl: URL(string: "http://test.com/")!, requestSuccess: { (data) in
            XCTAssertNil(data)
        }) { (error1) in
            XCTAssertNotNil(error1)
        }
    }

}
