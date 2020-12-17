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
        @Published var loadableImage: Loadable<Images>
        @Published var image: UIImage {
            didSet{
                storeImage()
            }
        }
        
        let container : DIContainer
        
        init(container: DIContainer, image: Loadable<Images> = .notRequested) {
            self.container = container
            self.image = UIImage(systemName: "camera")!
            _loadableImage = .init(initialValue: image)
            
            loadImage()
        }
        
        func loadImage() -> Void {
            container.services.imageService.loadImage(image: loadableSubject(\.loadableImage))
        }
        
        func storeImage() {
            if case let .loaded(image) = loadableImage {
                container.services.imageService.storeImage(image: image)
            }
        }
    }
}
