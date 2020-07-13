//
//  MainTableView.swift
//  Test-Project
//
//  Created by Victor Uriel Pacheco Garcia on 05/07/20.
//  Copyright © 2020 Victor Uriel Pacheco Garcia. All rights reserved.
//

import Foundation
import UIKit

final class MainTableView: UIView {
    
    //MARK: - Subviews declaration
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    //MARK: - Init
    convenience init() {
        self.init(frame: .zero)
        addSubViews()
        setConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - ConfigurableView extension
extension MainTableView: ConfigurableView {
    
    func addSubViews() {
        self.addSubview(tableView)
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
