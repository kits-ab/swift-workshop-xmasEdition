//
//  AppEnvironment.swift
//  workshop
//
//  Created by Pierre Sandboge on 2020-12-16.
//

import Foundation

struct AppEnvironment {
    let container : DIContainer
    
    static func bootstrap() -> AppEnvironment {
        let persistentStore = CoreDataStack(version: CoreDataStack.Version.actual)
        let dbRepository = DIContainer.DBRepository(imageDBRepository: RealImagesDBRepository(persistentStore: persistentStore))
        let services = DIContainer.Services(imageService: RealImageService(dbRepository: dbRepository.imageDBRepository))
        let diContainer = DIContainer(services: services)
        return AppEnvironment(container: diContainer)
    }
}
