//
//  JsonParser.swift
//  MovieList
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import UIKit

class JsonParser: NSObject {
    
    /**
     Parse the json from file with given name from given bundle.
     If parsed successfully, it returns the parsed object.
     If parsing failed, it returns `nil`.
     
     - Parameter filename: **name** of the json file
     - Parameter bundle: object of **Bundle** to which the file belongs to.
     
     - returns: the parsed **json object** on success **OR** returns **nil** if parsing `failed`..
     */
    func parseJsonFile(withName filename: String, fromBundle bundle: Bundle) -> Any? {
        
        guard let path = self.getJsonPathFromBundle(forFilename: filename, fromBundle: bundle) else {
            return nil
        }
        
        guard let jsonObject = self.parseJsonFromPath(path) else {
            return nil
        }
        
        return jsonObject
    }
    
    /**
     Checks if the file with the name passed exists in the given bundle.
     If the file exists, it returns the path for the file.
     If the file does not exists, it returns `nil`.
     
     - Parameter filename: **name** of the json file
     - Parameter bundle: object of **Bundle** to which the file belongs to.
     
     - returns: the **path** of the file if exists **OR** returns **nil** object if path doesn't exist.
     */
    private func getJsonPathFromBundle(forFilename filename: String, fromBundle bundle: Bundle) -> String? {
        guard let path = bundle.path(forResource: filename, ofType: "json") else {
            
            return nil
        }
        return path
    }
    
    /**
     Parse the json from file with the given path.
     If parsed successfully, it returns the parsed object.
     If parsing failed, it returns `nil`.
     
     - Parameter path: **path** of the json file
     
     - returns: the parsed **json object** on success **OR** **ni** if parsing or fetchting json contents from file `failed`.
     */
    private func parseJsonFromPath(_ path: String) -> Any?{
        var jsonObject: Any? = nil
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            jsonObject = self.parseJsonData(data)
        } catch let error {
            print("Failed to fetch contents of the file")
            print(error)
        }
        
        return jsonObject
    }
    
    /**
     Parse the json from json data.
     If parsed successfully, it returns the parsed object.
     If parsing failed, it returns `nil`.
     
     - Parameter jsonData: json data to be parsed in `Data` format
     
     - returns: the parsed **json object** on success **OR** returns **ni** if parsing `failed`.
     */
    func parseJsonData(_ jsonData: Data) -> Any? {
        var jsonObject: Any? = nil
        do {
            jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
        } catch let error {
            print("Failed to parse Json data. Details below.")
            print(error)
        }
        
        return jsonObject
    }
}
