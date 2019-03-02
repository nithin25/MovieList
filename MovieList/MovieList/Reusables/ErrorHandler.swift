//
//  ErrorHandler.swift
//  MovieList
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import Foundation

public enum ErrorHandler: Error {
    case apiResponseError(Error)
    case invalidJson
    case dataNotReceived
}
