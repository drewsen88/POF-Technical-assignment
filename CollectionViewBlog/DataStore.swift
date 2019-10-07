//
//  DataStore.swift
//  CollectionViewBlog
//
//  Created by Erica Millado on 7/3/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import Foundation
import UIKit

final class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var audiobooks: [Audiobook] = []
    var images: [UIImage] = []
    
    public func loadImage(for id:Int, width: Int, height: Int, with imageReceiver: @escaping (_: UIImage) -> Void ) {
        DispatchQueue.global(qos: .background).async {
            
            let book = self.audiobooks[id]
            let url = URL(string: book.coverImage)
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                self.images.append(image!)
                DispatchQueue.main.async {
                    imageReceiver(image!)
                }
            }
           
        }
    }


    func getBooks(completion: @escaping () -> Void) {
        
        APIClient.getAudiobooksAPI { (json) in
//            let feed = json["feed"] as? AudiobookJSON
            if let results = json as? [AudiobookJSON] {
                for dict in results {
                    let newAudiobook = Audiobook(dictionary: dict)
                    self.audiobooks.append(newAudiobook)
                }
                OperationQueue.main.addOperation {
                    completion()
                }
            }
        }
    }
    
    func getBookImages(completion: @escaping () -> Void) {
        getBooks { 
            for book in self.audiobooks {
                let url = URL(string: book.coverImage)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.images.append(image!)
                    OperationQueue.main.addOperation {
                        completion()
                    }

                }
//                dispatch_async(dispatch_get_main_queue(), refresh)
//                DispatchQueue.async(execute: refresh)
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
}
