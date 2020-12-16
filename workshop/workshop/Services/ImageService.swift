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
    private var dbRepository: ImagesDBRepository
    
    init(dbRepository: ImagesDBRepository) {
        self.dbRepository = dbRepository
    }

    func storeImage(image: Images) -> AnyPublisher<Images, Error> {
        return dbRepository.store(image: image)
    }

    func loadImage(image: LoadableSubject<Images>) {
        let cancelBag = CancelBag()
        image.wrappedValue.setIsLoading(cancelBag: cancelBag)
        dbRepository.image().sinkToLoadable {
            image.wrappedValue = $0.unwrap()
        }.store(in: cancelBag)
    }
}
