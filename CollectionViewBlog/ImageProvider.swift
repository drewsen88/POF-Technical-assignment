//
//  ImageProvider.swift
//  AsyncImageLoad
//
//  Created by James Shephard on 07/07/2017.
//  Copyright © 2017 James Shephard. All rights reserved.
//

import Foundation
import UIKit

public class ImageProvider {
    
    public func loadImage(for id:Int, width: Int, height: Int, with imageReceiver: @escaping (_: UIImage) -> Void ) {
        DispatchQueue.global(qos: .background).async {
            let image = self.renderRandom(with: id, width: width, height: height)
            Thread.sleep(forTimeInterval: 1.0 + drand48() * 2.0)
            DispatchQueue.main.async {
                imageReceiver(image)
            }
        }
    }
    
    func renderRandom(with seed: Int, width: Int, height: Int) -> UIImage {
        srand48(seed)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), true, 1)
        let context = UIGraphicsGetCurrentContext()
        
        for _ in 1 ... 5 {
            
            context!.setFillColor(red: CGFloat(drand48()),
                                  green: CGFloat(drand48()),
                                  blue: CGFloat(drand48()),
                                  alpha: 1)
            
            let size = 20.0 + drand48() * 30
            
            let rect = CGRect(x: drand48() * Double(width),
                              y: drand48() * Double(height),
                              width: size,
                              height: size)
            
            context!.fill(rect)
        }
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
}
