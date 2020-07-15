//
//  ConfigurableView.swift
//  Test-Project
//
//  Created by Victor Uriel Pacheco Garcia on 06/07/20.
//  Copyright © 2020 Victor Uriel Pacheco Garcia. All rights reserved.
//

import Foundation
import UIKit

// TODO: - When you try to document a class or a protocol try to use tripple slash instead 😉 `///` then you can CMD + Click to see the auto-generated documentation style

/// This protocol must be implemented by all View
/// classes to keep function naming consistency.
protocol ConfigurableView {
    func addSubViews()
    func setConstraints()
}
