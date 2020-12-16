//
//  ImageService.swift
//  workshop
//
//  Created by Pierre Sandboge on 2020-12-16.
//

import Combine

protocol ImageService {
    func storeImage(image: Images) -> AnyPublisher<Images, Error>
    func loadImage(image: LoadableSubject<Images>)
}

struct RealImageService: ImageService {
    func loadImage(image: LoadableSubject<Images>) {
        dbRepository.image().sink
    }
    
    private var dbRepository: ImagesDBRepository
    
    init(dbRepository: ImagesDBRepository) {
        self.dbRepository = dbRepository
    }

    func storeImage(image: Images) -> AnyPublisher<Images, Error> {
        return dbRepository.store(image: image)
    }
    
}
