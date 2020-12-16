//
//  Models.swift
//  workshop
//
//  Created by Emilia Nilsson on 2020-12-16.
//

import Foundation
import SwiftUI

struct Images {
    var img: UIImage
    
    init(img: UIImage) {
        self.img = img
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.img == rhs.img
    }
}
