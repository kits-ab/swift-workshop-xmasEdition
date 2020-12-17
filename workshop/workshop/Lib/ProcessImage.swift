//
//  ProcessImage.swift
//  workshop
//
//  Created by Emma Stålesjö on 2020-12-17.
//

import SwiftUI
import Foundation

struct ProcessImage {
    
    
    func process(image: UIImage) {
        let cgImage = image.cgImage
        let width = cgImage?.width ?? 1000
        let height = cgImage?.height ?? 1000
        let bitsPerComponent = cgImage?.bitsPerComponent ?? 8
        let bytesPerRow = cgImage?.bytesPerRow ?? width*4
        let bitmapInfo: UInt32 = (cgImage?.bitmapInfo)!.rawValue
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB();
        let pixels = UnsafeMutablePointer<UInt32>.allocate(capacity: width*height)
            
        let context: CGContext = CGContext(data: pixels, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace,  bitmapInfo: bitmapInfo)!;
        
        
        
        

    }
}
