//
//  Audiobook.swift
//  CollectionViewBlog
//
//  Created by Erica Millado on 7/3/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import Foundation

struct Audiobook {
    let name: String
//    let author: String
    let coverImage: String
    
    init(dictionary: AudiobookJSON) {
        self.name = dictionary["title"] as! String
//        self.author = dictionary["artistName"] as! String
        self.coverImage = dictionary["url"] as! String
    }
    
}
