//
//  NetworkManager.swift
//  MovieList
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    func makeDataRequest(withUrl url: URL, requestSuccess: @escaping ((_ body: Any?) -> Void), requestFailed: @escaping ((_ error: ErrorHandler) -> Void)) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let fetchTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                //print("Error: error in fetching data. Details below:")
                print(error)
                requestFailed(ErrorHandler.apiResponseError(error))
                return
            }
        
            guard let responseData = data else {
                //print("Error: Did not receive any data.")
                requestFailed(ErrorHandler.dataNotReceived)
                return
            }
            //print("responseData: \(responseData)")
            let parser = JsonParser()
            let parsedData = parser.parseJsonData(responseData)
            guard let jsonObject = parsedData else {
                print("Error: Request provided invalid json.")
                requestFailed(ErrorHandler.invalidJson)
                return
            }
            
            //print(jsonObject)
            requestSuccess(jsonObject)
        }
        fetchTask.resume()
    }
}
