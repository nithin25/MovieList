//
//  JsonParserTests.swift
//  MovieListTests
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import XCTest
@testable import MovieList

class JsonParserTests: XCTestCase {
    
    var parser = JsonParser()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testParseJsonFileValidFilePath() {
        //file path exists
        let filename = "JsonParserTestsValidJson"
        let testBundle = Bundle(for: type(of: self))
        let jsonObject = parser.parseJsonFile(withName: filename, fromBundle: testBundle)
        XCTAssertNotNil(jsonObject)
    }
    
    func testParseJsonFileInvalidFilePathPath() {
        //file path doesn't exist. so should be nil
        let filename = "random$"
        let testBundle = Bundle(for: type(of: self))
        let jsonObject = parser.parseJsonFile(withName: filename, fromBundle: testBundle)
        XCTAssertNil(jsonObject)
    }
    
    func testParseJsonFileWithValidJsonFile() {
        let filename = "JsonParserTestsValidJson"
        let testBundle = Bundle(for: type(of: self))
        let jsonObject = parser.parseJsonFile(withName: filename, fromBundle: testBundle)
        XCTAssertNotNil(jsonObject)
    }
    
    func testParseJsonFileWithInvalidJsonFile() {
        let invalidFileName = "JsonParserTestsInvalidJson"
        let testBundle = Bundle(for: type(of: self))
        let jsonObject = parser.parseJsonFile(withName: invalidFileName, fromBundle: testBundle)
        XCTAssertNil(jsonObject)
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
