//
//  MainView.swift
//  Test-Project
//
//  Created by Victor Uriel Pacheco Garcia on 04/07/20.
//  Copyright © 2020 Victor Uriel Pacheco Garcia. All rights reserved.
//

import Foundation
import UIKit

final class ScrollMainView: UIView {
    
    //MARK: - Subviews declaration
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Estos son unos perritos"
        label.backgroundColor = .brown
        label.textColor = .white
        return label
    }()
    
    lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .redraw
        return imageView
    }()
    
    lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .redraw
        return imageView
    }()
    
    lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubViews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - ConfigurableView extension
extension ScrollMainView: ConfigurableView {
    
    func setConstraints() {
        self.contentScrollView.fillSuperviewSafeArea()
        self.contentStackView.fillSuperview()
        self.contentStackView.setConstaints(widthAnchor: self.widthAnchor)
    }
    
    func addSubViews() {
        self.addSubview(contentScrollView)
        self.contentScrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(imageView1)
        contentStackView.addArrangedSubview(imageView2)
        contentStackView.addArrangedSubview(imageView3)
    }
    
}
