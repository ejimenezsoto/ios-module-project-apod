//
//  PhotoCollectionViewCell.swift
//  AstronomyPictureOfTheDay
//
//  Created by Enzo Jimenez-Soto on 7/23/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    
    var photoController: PhotoController?
    var photo: EJSPhoto? {
        didSet {
            setupViews()
        }
    }
    
    private func setupViews() {
        guard let photo = photo else { return }
        
        dateLabel.text = photoController?.df.string(from: photo.date)
        
    }
    
    
    override func prepareForReuse() {
        imageView.image = nil
    }}
