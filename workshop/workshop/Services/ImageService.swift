//
//  ImageService.swift
//  workshop
//
//  Created by Pierre Sandboge on 2020-12-16.
//

import SwiftUI
import Combine

protocol ImageService {
    @discardableResult
    func storeImage(image: Images) -> AnyPublisher<Void, Error>
    func loadImage(image: LoadableSubject<Images>)
    func processImage(image: UIImage) -> UIImage
}

struct RealImageService: ImageService {
    private var dbRepository: ImagesDBRepository
    
    init(dbRepository: ImagesDBRepository) {
        self.dbRepository = dbRepository
    }

    func storeImage(image: Images) -> AnyPublisher<Void, Error> {
        return dbRepository.store(image: image)
    }

    func loadImage(image: LoadableSubject<Images>) {
        let cancelBag = CancelBag()
        image.wrappedValue.setIsLoading(cancelBag: cancelBag)
        dbRepository.image().sinkToLoadable {
            image.wrappedValue = $0.unwrap()
        }.store(in: cancelBag)
    }
    
    func processImage(image: UIImage) -> UIImage {
        ProcessImage().process(image: image)
    }
}

struct StubImageService: ImageService {
    func storeImage(image: Images) -> AnyPublisher<Void, Error> {
        Just<Void>.withErrorType(Error.self)
    }
    
    func loadImage(image: LoadableSubject<Images>) {
    }
    
    func processImage(image: UIImage) -> UIImage {
        UIImage()
    }
}
