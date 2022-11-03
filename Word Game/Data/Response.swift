//
//  Data.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import Foundation

typealias RequestResponse<T> = ((Result<T, Error>) -> Void)
typealias Response<T> = (Result<T, Error>)

enum ServiceError : Error{
    case fileNotFound
}

struct WordPair : Codable {
    var text_eng : String
    var text_spa : String
}

