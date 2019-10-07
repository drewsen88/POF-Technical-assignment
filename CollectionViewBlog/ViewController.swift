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

    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 10, height: UIScreen.main.bounds.height/2 - 10)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0

        self.collectionView.collectionViewLayout = flowLayout
        
        store.getBooks {
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.audiobooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 5.0
        
        cell.contentView.layer.borderColor = UIColor.white.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.backgroundColor = UIColor.clear
        
        cell.bookLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))

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

