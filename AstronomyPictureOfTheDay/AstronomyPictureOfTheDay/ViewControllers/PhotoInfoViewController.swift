//
//  PhotoInfoViewController.swift
//  AstronomyPictureOfTheDay
//
//  Created by Enzo Jimenez-Soto on 7/23/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoTextView: UITextView!
    
    // MARK: - Properties
    var photo: EJSPhoto? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Private Methods
    private func updateViews() {
        guard let photo = photo else { return }
        if isViewLoaded {
            titleLabel.text = photo.title
            infoTextView.text = photo.explanation
        }
        
        
        
        
    }
    
}
