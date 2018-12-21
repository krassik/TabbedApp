//
//  CollectionViewCell.swift
//  Tabbed
//
//  Created by tati on 12/20/18.
//  Copyright © 2018 ps. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var video: Video? = nil {
        didSet {
            if let imagePath = video?.thumbnail {
                imageView.downloaded(from: imagePath, contentMode: .scaleToFill)
            }
        }
    }
    

    
    override func awakeFromNib() {
        
    }
}
