//
//  StartViewModel.swift
//  workshop
//
//  Created by Emma Stålesjö on 2020-12-15.
//

import SwiftUI

extension StartView {
    class ViewModel: ObservableObject {
        @Published var xmas : String = "X-MAS Edition 🎅🏻🤶🏻🎄"
        @Published var pickerBool: Bool = false
        @Published var processedImage: UIImage = UIImage()
        @Published var loadableImage: Loadable<Images>
        @Published var image: [UIImage] = [] {
            didSet {
                storeImage(image: Images(img: image.first!))
            }
        }
        @Published var imageIsProcessing: Bool = false
        
        let container : DIContainer
        
        init(container: DIContainer, image: Loadable<Images> = .notRequested) {
            self.container = container
            _loadableImage = .init(initialValue: image)
        }
        
        func loadImage() -> Void {
            container.services.imageService.loadImage(image: loadableSubject(\.loadableImage))
        }
        
        private func storeImage(image: Images?) {
            if let img = image {
                container.services.imageService.storeImage(image: img).sinkToResult{  [self] result in
                    if case .success(_) = result {
                        loadImage()
                    }
                }.store(in: CancelBag())
            }
        }
        
        func processImage() {
            imageIsProcessing = true
            print("Image is processing: \(imageIsProcessing)")
            if case let .loaded(img) = loadableImage {
                processedImage = container.services.imageService.processImage(image: img.img.copy() as! UIImage)
            }
            imageIsProcessing = false
            print("Image is done")
        }
    }
}
