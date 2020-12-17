//
//  CoreDataModels.swift
//  workshop
//
//  Created by Emilia Nilsson on 2020-12-16.
//

import Foundation
import CoreData
import SwiftUI

extension ImageMO: ManagedEntity { }

extension Images {
    @discardableResult
    func store(in context: NSManagedObjectContext) -> ImageMO? {
        guard let imageMO = ImageMO.insertNew(in: context) else { return nil }
        imageMO.id = self.id
        imageMO.img = self.img.pngData()
        
        return imageMO
    }
    
    init?(managedObject mo: ImageMO) {
        guard let data = mo.img, let img = UIImage(data: data)
              else { return nil }
        
        self.init(img: img)
    }
}
