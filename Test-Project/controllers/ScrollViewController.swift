//
//  MainViewController.swift
//  Test-Project
//
//  Created by Victor Uriel Pacheco Garcia on 04/07/20.
//  Copyright © 2020 Victor Uriel Pacheco Garcia. All rights reserved.
//

import Foundation
import UIKit

final class ScrollViewController: UIViewController {
    
    //MARK: - View
    // TODO: - Please try to never use force cast 😉
    //lazy var rootView = view as! ScrollMainView
    // Instead check this better approach:
    private let rootView = ScrollMainView()
    
    //MARK: - Properties
    private let semaphore = DispatchSemaphore(value: 3)
    private var counter = 0
    var breed: String?
    
    //MARK: - View type assignment in loadView
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Please choose a more descriptive naming here 😉
        // self.callApi()
        fetchData()
    }
    
    //MARK: - API Call
    private func fetchData() {
        if let breed = self.breed {
            // TODO: - Please try to never use force unwrap 😉
            // rootView.titleLabel.text = rootView.titleLabel.text! + " " + breed
            // Instead check this:
            let titleText = rootView.titleLabel.text ?? ""
            rootView.titleLabel.text = titleText + " " + breed
            
            // TODO: - Same here, just try to use result instead
//            DogAPI.requestImageOf(br😉eed: breed, completionHandler: self.handleRandomImageResponse(dogImage:error:))
//            DogAPI.requestImageOf(breed: breed, completionHandler: self.handleRandomImageResponse(dogImage:error:))
//            DogAPI.requestImageOf(breed: breed, completionHandler: self.handleRandomImageResponse(dogImage:error:))
            
            // TODO: - Obviously this is not working for now but you may have some fun trying to implement it using `Result<UIImage, Error>` instead of `(image: UIImage?, error: Error?)` 😉
            DogAPI.requestImageOf(breed: breed) { result in
                switch result {
                case .success(let image):
                    break
                case .failure(let error):
                    break
                }
            }
        } else {
            // TODO: - Obviously this is not working for now but you may have some fun trying to implement it using `Result<UIImage, Error>` instead of `(image: UIImage?, error: Error?)` 😉
//            DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse)
//            DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse)
//            DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse)
        }
    }
    
    //MARK: - API callback methods
    private func handleRandomImageResponse(image: UIImage?, error: Error?) {
        defer { semaphore.signal() }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if(self.counter == 0) {
                self.rootView.imageView1.image = image
            } else if(self.counter == 1) {
                self.rootView.imageView2.image = image
            } else if(self.counter == 2) {
                self.rootView.imageView3.image = image
            }
            self.counter += 1
        }
    }
    
    private func handleRandomImageResponse(dogImage: DogImage?, error: Error?) {
        guard let dogImage = dogImage else { return }
        let imageUrl = URL(string: dogImage.message)
        guard imageUrl != nil else { return }
        semaphore.wait()
        DogAPI.requestImageFile(url: imageUrl!, completionHandler: self.handleRandomImageResponse)
    }
    
}
