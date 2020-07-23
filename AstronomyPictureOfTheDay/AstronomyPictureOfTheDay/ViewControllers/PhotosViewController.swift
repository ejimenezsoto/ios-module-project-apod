//
//  PhotosViewController.swift
//  AstronomyPictureOfTheDay
//
//  Created by Enzo Jimenez-Soto on 7/23/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

        // MARK: - IBOutlets
        @IBOutlet var collectionView: UICollectionView!
        
        // MARK: - Properties
        var currentMonth: [Date] = []
        let photoController = PhotoController()
        var month: Int = 7
        
        // MARK: - View Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let firstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch")
            if !firstLaunch {
                performSegue(withIdentifier: "OnboardingModalSeuge", sender: self)
                UserDefaults.standard.set(true, forKey: "firstLaunch")
            }
            
           
            title = "July"
            currentMonth = photoController.getDays(for: month, in: 2020)
            
            
        }
        
        // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowImageDetailSegue" {
                guard let photoDetailVC = segue.destination as? PhotoDetailViewController else { return }
                guard let selected = collectionView.indexPathsForSelectedItems else { return }
                photoDetailVC.photo = photoController.sortedPhotos[selected[0].row]
                photoDetailVC.photoController = photoController
            }
        }
        
        private func loadImage(for cell: PhotoCollectionViewCell, with photo: EJSPhoto) {
            photoController.fetchPhotoData(url: photo.url) { (data, error) in
                if let error = error {
                    NSLog("Error fetching photos \(error)")
                    return
                }
                
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
    }

    extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return currentMonth.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            
            photoController.fetchPhotoForDate(date: currentMonth[indexPath.row]) { (error) in
                if let error = error {
                    NSLog("Error fetching photo for date: \(self.currentMonth[indexPath.row]) error: \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    guard let photo = self.photoController.sortedPhotos.filter ({ $0.date == self.currentMonth[indexPath.row] }).first else { fatalError() }
                    cell.photo = photo
                    cell.photoController = self.photoController
                    self.loadImage(for: cell, with: photo)
                }
                
            }
            
            
            return cell
        }

}
