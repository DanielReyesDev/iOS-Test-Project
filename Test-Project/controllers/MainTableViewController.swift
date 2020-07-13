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
    lazy var rootView = view as! MainTableView
    
    //MARK: - Properties
    fileprivate var data: [String] = []
    
    //MARK: - View type assignment in loadView
    override func loadView() {
        super.loadView()
        self.view = MainTableView()
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
        DogAPI.requestAllBreeds(completionHandler: handleBreedsResponse(breeds:error:))
    }
    
    //MARK: - Setup private methods
    private func setupTableView() {
        self.rootView.tableView.delegate = self
        self.rootView.tableView.dataSource = self
        self.rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GreetingCell")
    }
    
    //MARK: - Navigation methods
    private func navigateMainVC(breed: String) {
        let vc = ScrollViewController()
        vc.breed = breed
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - API callback methods
    private func handleBreedsResponse(breeds: [String], error: Error?) {
        if !breeds.isEmpty {
            data = breeds
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.rootView.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource extension
extension MainTableViewController: UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GreetingCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Dog breeds" : ""
    }
}

//MARK: - UITableViewDelegate extension
extension MainTableViewController: UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateMainVC(breed: data[indexPath.row])
    }
}


