//
//  MainTableViewController.swift
//  Test-Project
//
//  Created by Victor Uriel Pacheco Garcia on 05/07/20.
//  Copyright © 2020 Victor Uriel Pacheco Garcia. All rights reserved.
//

import Foundation
import UIKit

final class MainTableViewController: UIViewController {
    
    //MARK: - View
    // TODO: - Please try to never use force cast 😉
    //lazy var rootView = view as! MainTableView
    private let rootView = MainTableView()
    
    //MARK: - Properties
    // TODO: - Please use `fileprivate` only when necessary, here you can use a simple `private` statement 😉
    // fileprivate var data: [String] = []
    private var data: [String] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.rootView.tableView.reloadData()
            }
        }
    }
    
    // TODO: - Please always try to define a constant instead of using the raw value "GreetingCell" twice
    // Remember DRY rule: Don't Repeat Yourself
    private let cellId = "GreetingCell"
    
    //MARK: - View type assignment in loadView
    override func loadView() {
        super.loadView()
        self.view = rootView
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do not overuse `self` use it only when neccesary 😉
        // self.setupTableView()
        setupTableView()
        fetchDogs()
    }
    
    //MARK: - Private methods
    private func fetchDogs() {
        // TODO: - Please try to use Result instead of having raw values 😉
        // DogAPI.requestAllBreeds(completionHandler: handleBreedsResponse(breeds:error:))
        DogAPI.requestAllBreeds { result in
            self.handleResponse(result: result)
        }
    }
    
//    private func handleBreedsResponse(breeds: [String], error: Error?) {
//        if !breeds.isEmpty {
//            data = breeds
//        }
//
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            self.rootView.tableView.reloadData()
//        }
//    }
    private func handleResponse(result: Result<[String], Error>) {
        switch result {
        case .success(let breeds):
            self.data = breeds
        case .failure(let error):
            self.displayAlert(with: error)
        }
    }
    
    // TODO: - My recommendatiion is to present a default Alert View to display the error to the user 😉
    // By doing that you will earn more points in the interview ✌🏼
    private func displayAlert(with error: Error) {
        
    }
    
    private func setupTableView() {
        self.rootView.tableView.delegate = self
        self.rootView.tableView.dataSource = self
        self.rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func navigateMainVC(breed: String) {
        let vc = ScrollViewController()
        vc.breed = breed
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource extension
extension MainTableViewController: UITableViewDataSource {
    
    // TODO: - internal is the default accesor so you can omit it 😉
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // TODO: - internal is the default accesor so you can omit it 😉
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    // TODO: - internal is the default accesor so you can omit it 😉
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Dog breeds" : ""
    }
}

//MARK: - UITableViewDelegate extension
extension MainTableViewController: UITableViewDelegate {
    
    // TODO: - internal is the default accesor so you can omit it 😉
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateMainVC(breed: data[indexPath.row])
    }
}


