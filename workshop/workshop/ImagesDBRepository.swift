//
//  ImagesDBRepository.swift
//  workshop
//
//  Created by Emilia Nilsson on 2020-12-16.
//

import CoreData
import Combine

protocol ImagesDBRepository {
    var persistentStore: PersistentStore { get }
    func store(image: Images) -> AnyPublisher<Void, Error>
    func image() -> AnyPublisher<Images?, Error>
}

struct RealImagesDBRepository: ImagesDBRepository {
    let persistentStore: PersistentStore
    
    func store(image: Images) -> AnyPublisher<Void, Error> {
        return persistentStore.update { context in
            image.store(in: context)
        }
    }
    
    func image() -> AnyPublisher<Images?, Error> {
        let fetchImage = ImageMO.image()
        return persistentStore.fetch(fetchImage) {
            Images(managedObject: $0)
        }.compactMap{
            return $0.first
        }.eraseToAnyPublisher()
    }
}

extension ImageMO {
    static func image() -> NSFetchRequest<ImageMO> {
        let request = newFetchRequest()
        request.fetchBatchSize = 1
        return request
    }
}
