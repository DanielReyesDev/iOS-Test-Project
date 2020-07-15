//
//  DogAPI.swift
//  Test-Project
//
//  Created by Victor Uriel Pacheco Garcia on 12/07/20.
//  Copyright © 2020 Victor Uriel Pacheco Garcia. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case noDataError
}

final class DogAPI {
    
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case listAllBreeds
        case randomImageFromBreed(String)
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageFromBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task =  URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let dowloadedImage = UIImage(data: data)
            completionHandler(dowloadedImage, nil)
        })
        task.resume()
    }
    
    class func requestRandomImage(completionHandler: @escaping (Result<DogImage, Error>) -> (Void)) {
        let task = URLSession.shared.dataTask(with: self.Endpoint.randomImageFromAllDogsCollection.url) { (data, response, error) in
            guard let data = data else {
                // Check this, the idea is to propagate a meaningful error back to it's caller
                completionHandler(.failure(NetworkError.noDataError))
                return
            }
            let decoder = JSONDecoder()
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                completionHandler(.success(imageData))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    class func requestAllBreeds(completionHandler: @escaping (Result<[String], Error>) -> (Void)) {
        let task = URLSession.shared.dataTask(with: self.Endpoint.listAllBreeds.url) { (data, response, error) in
            guard let data = data else {
                completionHandler(.failure(NetworkError.noDataError))
                return
            }
            let decoder = JSONDecoder()
            // TODO: - It's much better if you try to handle the error and propagate the error back to it's caller,
            // That's one reason why Result<> is much better
            let breeds = try! decoder.decode(BreedResponse.self, from: data)
            let breedsList = breeds.message.keys.map({$0})
            completionHandler(.success(breedsList))
        }
        task.resume()
    }
    
    // TODO: - Try to implement the other methods with Result and using a generic 😉
//    class func requestImageOf(breed: String, completionHandler: @escaping (DogImage?, Error?) -> (Void)) {
//        let task = URLSession.shared.dataTask(with: self.Endpoint.randomImageFromBreed(breed).url, completionHandler: {
//            (data, response, error) in
//            guard let data = data else {
//                completionHandler(nil, error)
//                return
//            }
//            let decoder = JSONDecoder()
//            let image = try! decoder.decode(DogImage.self, from: data)
//            completionHandler(image, nil)
//        })
//        task.resume()
//    }
    
    class func requestImageOf(breed: String, completionHandler: @escaping (Result<DogImage, Error>) -> (Void)) {
        // `self.Endpoint.randomImageFromBreed(breed)` -> `Endpoint.randomImageFromBreed(breed)`
        // self not needed 😉 my recommendation is to use it only when is strictly needed
        DogAPI.performRequest(endpoint: Endpoint.randomImageFromBreed(breed), completion: completionHandler)
    }
    
    // TODO: - Just check this is a super basic example of a generic that performs the request and decodes the result
    // But try to implement one by yourself 😄
    class func performRequest<T: Decodable>(endpoint: DogAPI.Endpoint, completion: @escaping(Result<T, Error>) -> Void ) {
        URLSession.shared.dataTask(with: endpoint.url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
