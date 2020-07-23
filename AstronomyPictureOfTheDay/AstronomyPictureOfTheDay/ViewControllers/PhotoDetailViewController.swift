//
//  PhotoDetailViewController.swift
//  AstronomyPictureOfTheDay
//
//  Created by Enzo Jimenez-Soto on 7/23/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var infoButton: UIButton!
    
    // MARK: - Properties
    var photoController: PhotoController?
    var photo: EJSPhoto?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Private Methods
    private func updateViews() {
        guard let photo = photo else { return }
        
        photoController?.fetchPhotoData(url: photo.url) { (data, error) in
            if let error = error {
                NSLog("Error fetching photos \(error)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowImageInfoSegue" {
            guard let photoInfoVC = segue.destination as? PhotoInfoViewController else { return }
            guard let photo = photo else { return }
            photoInfoVC.photo = photo
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
    }
    

}
