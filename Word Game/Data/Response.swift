//
//  Data.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import Foundation

typealias Completion = (Result<BaseResponse, Error>) -> Void
typealias RequestResponse<T> = ((Result<T, Error>) -> Void)
typealias Response<T> = (Result<T, Error>)

enum ServiceError : Error{
    case fileNotFound
}

struct BaseResponse : Codable {
    var wordPairs : [WordPair] = []
}

struct WordPair : Codable {
    var text_eng : String
    var text_spa : String
}

