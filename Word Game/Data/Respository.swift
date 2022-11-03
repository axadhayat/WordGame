//
//  Respository.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import Foundation

protocol Repository{
    func fetch<T:Decodable> (completion:@escaping RequestResponse<T>)
}

final class LocalRepository : Repository{
    
    private var fileName:String
    private var fileExtansion:String
    
    internal init(fileName: String, fileExtansion: String) {
        self.fileName = fileName
        self.fileExtansion = fileExtansion
    }
    
    convenience init(){
        self.init(fileName: "words", fileExtansion: "json")
    }
    
    func fetch<T:Decodable> (completion:@escaping RequestResponse<T>) {
        
        guard let pathUrl = Bundle.main.url(forResource: fileName, withExtension: fileExtansion) else {
            completion(.failure(ServiceError.fileNotFound))
            return }
        do {
            let jsonData = try Data(contentsOf: pathUrl)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let result = try decoder.decode(T.self, from: jsonData)
            completion(.success(result))
        } catch let error {
            completion(.failure(error))
        }
    }
}
