//
//  BreedResponse.swift
//  Test-Project
//
//  Created by Victor Uriel Pacheco Garcia on 13/07/20.
//  Copyright © 2020 Victor Uriel Pacheco Garcia. All rights reserved.
//

import Foundation

struct BreedResponse: Codable {
    let message: [String: [String]]
    let status: String
}
