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
    lazy var rootView = view as! ScrollMainView
    
    //MARK: - Properties
    let semaphore = DispatchSemaphore(value: 3)
    var counter = 0
    var breed: String?
    
    //MARK: - View type assignment in loadView
    override func loadView() {
        super.loadView()
        view = ScrollMainView()
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callApi()
    }
    
    //MARK: - API Call
    private func callApi() {
        if let breed = self.breed {
            rootView.titleLabel.text = rootView.titleLabel.text! + " " + breed
            DogAPI.requestImageOf(breed: breed, completionHandler: self.handleRandomImageResponse(dogImage:error:))
            DogAPI.requestImageOf(breed: breed, completionHandler: self.handleRandomImageResponse(dogImage:error:))
            DogAPI.requestImageOf(breed: breed, completionHandler: self.handleRandomImageResponse(dogImage:error:))
        } else {
            DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse)
            DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse)
            DogAPI.requestRandomImage(completionHandler: self.handleRandomImageResponse)
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
