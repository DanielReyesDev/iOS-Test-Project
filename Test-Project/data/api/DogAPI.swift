//
//  DogAPI.swift
//  Test-Project
//
//  Created by Victor Uriel Pacheco Garcia on 12/07/20.
//  Copyright © 2020 Victor Uriel Pacheco Garcia. All rights reserved.
//

import Foundation
import UIKit

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
    
    class func requestImageOf(breed: String, completionHandler: @escaping (DogImage?, Error?) -> (Void)) {
        let task = URLSession.shared.dataTask(with: self.Endpoint.randomImageFromBreed(breed).url, completionHandler: {
            (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let image = try! decoder.decode(DogImage.self, from: data)
            completionHandler(image, nil)
        })
        task.resume()
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
    
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> (Void)) {
        let task = URLSession.shared.dataTask(with: self.Endpoint.randomImageFromAllDogsCollection.url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    
    class func requestAllBreeds(completionHandler: @escaping ([String], Error?) -> (Void)) {
        let task = URLSession.shared.dataTask(with: self.Endpoint.listAllBreeds.url) { (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breeds = try! decoder.decode(BreedResponse.self, from: data)
            let breedsList = breeds.message.keys.map({$0})
            completionHandler(breedsList, nil)
        }
        task.resume()
    }
}
