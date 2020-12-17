//
//  ImageService.swift
//  workshop
//
//  Created by Pierre Sandboge on 2020-12-16.
//

import Combine

protocol ImageService {
    func storeImage(image: Images)
    func loadImage(image: LoadableSubject<Images>)
}

struct RealImageService: ImageService {
    private var dbRepository: ImagesDBRepository
    
    init(dbRepository: ImagesDBRepository) {
        self.dbRepository = dbRepository
    }

    func storeImage(image: Images) {
        dbRepository.store(image: image).sinkToResult{ result in
            switch result {
                case .success(_): print("Successfully stored image")
                case .failure(let error): print(error)
            }
        }.store(in: CancelBag())
    }

    func loadImage(image: LoadableSubject<Images>) {
        let cancelBag = CancelBag()
        image.wrappedValue.setIsLoading(cancelBag: cancelBag)
        dbRepository.image().sinkToLoadable {
            image.wrappedValue = $0.unwrap()
        }.store(in: cancelBag)
    }
}

struct StubImageService: ImageService {
    func storeImage(image: Images) {
    }
    
    func loadImage(image: LoadableSubject<Images>) {
    }
}
