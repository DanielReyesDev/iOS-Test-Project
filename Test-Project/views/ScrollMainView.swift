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
    // TODO: - Try to use `let` instead of `lazy var` whenever is possible.
    // Remember to use `lazy var` only when needed 😉
//    lazy var contentScrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        return scrollView
//    }()
    private let contentScrollView = UIScrollView()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    // Remember to use `lazy var` only when needed 😉
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Estos son unos perritos"
        label.backgroundColor = .brown
        label.textColor = .white
        return label
    }()
    
    // Remember to use `lazy var` only when needed 😉
    let imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .redraw
        return imageView
    }()
    
    // Remember to use `lazy var` only when needed 😉
    let imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .redraw
        return imageView
    }()
    
    // Remember to use `lazy var` only when needed 😉
    let imageView3: UIImageView = {
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
    
    // TODO: - Add @available(*, unavailable) to force the compiler to omit this `init` because we're using programatic views instead of storyboards. 😉
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - ConfigurableView extension
extension ScrollMainView: ConfigurableView {
    
    func setConstraints() {
        // TODO: - Try to set the constraints manually without the extension just to practice! 😉
        // You will be asked to do it by yourself without extensions
        // Note: omit the overuseness of `self`
        contentScrollView.fillSuperviewSafeArea()
        contentStackView.fillSuperview()
        contentStackView.setConstaints(widthAnchor: widthAnchor)
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
