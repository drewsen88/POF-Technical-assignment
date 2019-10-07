//
//  ViewController.swift
//  CollectionViewBlog
//
//  Created by Erica Millado on 7/3/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private let imageWidth = 600
    private let imageHeight = 600

    private var imageCache = Dictionary<IndexPath, UIImage>()
    var imageProvider: ImageProvider?

    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
                
        store.getBooks {
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.audiobooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        let book = store.audiobooks[indexPath.row]
        
//        cell.displayContent(image: store.images[indexPath.row], title: book.name)

        
        cell.bookLabel?.text = String(format: "%d:%d", indexPath.section, indexPath.row);
        
        if let image = cachedImage(at: indexPath) {
            cell.bookImage?.isHidden = false
            cell.bookImage?.image = image
        }
        else {
            cell.bookImage?.isHidden = true
        }

        return cell
        
    }
    
    func cachedImage(at indexPath: IndexPath) -> UIImage? {
        let image = imageCache[indexPath]
        if(image == nil) {
            loadImage(for: indexPath)
            return nil
        }
        else {
            return image
        }
    }
    
    func loadImage(for indexPath: IndexPath) {
        store.loadImage(for: indexPath.row, width:imageWidth, height: imageHeight) { image in
            self.imageLoaded(image: image, for: indexPath)
        }
    }
    
    func imageLoaded(image: UIImage, for indexPath: IndexPath) {
        imageCache[indexPath] = image
        self.collectionView?.reloadItems(at: [indexPath])
    }

}

