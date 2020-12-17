//
//  Models.swift
//  workshop
//
//  Created by Emilia Nilsson on 2020-12-16.
//

import Foundation
import SwiftUI

struct Images {
    var id: String
    var img: UIImage
    
    init(id: String = "1", img: UIImage) {
        self.img = img
        self.id = id
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.img == rhs.img
    }
}
