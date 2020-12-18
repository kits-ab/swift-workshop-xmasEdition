//
//  ProcessImage.swift
//  workshop
//
//  Created by Emma Stålesjö on 2020-12-17.
//

import SwiftUI
import Foundation

struct ProcessImage {
    func process(image: UIImage) -> UIImage {
        let cgImage = image.cgImage
        let width = cgImage?.width ?? 1000
        let height = cgImage?.height ?? 1000
        let bitsPerComponent = cgImage?.bitsPerComponent ?? 8
        let bytesPerRow = cgImage?.bytesPerRow ?? width*4
        let bitmapInfo: UInt32 = (cgImage?.bitmapInfo)!.rawValue
        let colorSpace: CGColorSpace = cgImage?.colorSpace ?? CGColorSpaceCreateDeviceRGB()
        let pixels = UnsafeMutablePointer<UInt32>.allocate(capacity: width*height)
            pixels.initialize(repeating: 0, count: width*height)
        let context: CGContext = CGContext(data: pixels, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)!
        pixels.pointee = 0
        context.draw(cgImage!, in: CGRect(x: 0,y: 0,width: width, height: height))
        
        for pixel in 0..<(width*height) {
            let red = pixels[pixel] & 0xff
            let green = (pixels[pixel]>>8) & 0xff
            if (red > green) {
                pixels[pixel] = pixels[pixel] & 0x0000ff
            } else {
                pixels[pixel] = pixels[pixel] & 0x00ff00
            }
        }
        
        if let result = context.makeImage() {
            return UIImage(cgImage: result)
        }
        return UIImage(systemName: "camera")!
    }
}
