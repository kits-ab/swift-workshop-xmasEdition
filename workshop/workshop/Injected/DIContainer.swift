//
//  DIContainer.swift
//  workshop
//
//  Created by Pierre Sandboge on 2020-12-16.
//
import SwiftUI

struct DIContainer: EnvironmentKey {
    let services: Services
    static var defaultValue: DIContainer {
        return DIContainer(services: .init(imageService: RealImageService(dbRepository: RealImagesDBRepository(persistentStore: CoreDataStack(version: CoreDataStack.Version.actual)))))
    }
    
    struct Services{
        let imageService : ImageService
    }
    
    struct DBRepository {
        let imageDBRepository: ImagesDBRepository
    }
}

extension EnvironmentValues {
    var container: DIContainer {
        get {
            self[DIContainer.self]
        }
        
        set {
            self[DIContainer.self] = newValue
        }
    }
}
