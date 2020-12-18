//
//  SwiftUIImagePickerView.swift
//  miyawaki
//
//  Created by Pierre Sandboge on 2020-12-16.
//

import SwiftUI
import PhotosUI

struct SwiftUIImagePickerView: UIViewControllerRepresentable {
    
    @Binding var images: [UIImage]
    @Binding var showPicker: Bool
    var selectionLimit: Int
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = selectionLimit
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {

        var parent: SwiftUIImagePickerView
        
        init(parent: SwiftUIImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            parent.showPicker.toggle()
            
            for img in results {
                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    img.itemProvider.loadObject(ofClass: UIImage.self) { (image, err) in
                        guard let image1 = image else {
                            return
                        }
                        
                        DispatchQueue.main.async {
                            if self.parent.images.count > 0 {
                                self.parent.images[0] = image1 as! UIImage
                            } else {
                                self.parent.images.append(image1 as! UIImage)
                            }
                        }
                    }
                } else {
                    parent.showPicker.toggle()
                }
            }
        }
    }
}
