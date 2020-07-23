//
//  PhotoController.swift
//  AstronomyPictureOfTheDay
//
//  Created by Enzo Jimenez-Soto on 7/23/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import Foundation

class PhotoController {
    
    
    // MARK: - Properties
    private let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
    private let apiKey = "Fd1yDypAl5UsjGvxcIUDMj5KYoaijVfxnBZb07Ft"
    private var photos: [EJSPhoto] = []
    var sortedPhotos:[EJSPhoto] {
        return photos.sorted(by: { $0.date < $1.date })
    }

    
    let df: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    func fetchPhotoForDate(date: Date, completion: @escaping (Error?)->()){
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "date", value: df.string(from: date))
        ]
        
        let requestURL = urlComponents.url!
        
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                NSLog("Error receiving data for date(\(date)): \(error)")
                completion(error)
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Server did not return a successful URL response of 200.")
                completion(NetworkError.badResponse)
                return
            }
            
            guard let data = data else {
                NSLog("Server did not return good data")
                completion(NetworkError.badData)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                guard let jsonDate = json!["date"],
                    let explanation = json!["explanation"],
                    let jsonURL = json!["url"],
                    let title = json!["title"] else {
                        NSLog("Could not decode properties from JSon: \(String(describing: json))")
                        completion(NetworkError.errorDecoding)
                        return
                }
                
                
                let url = URL(string: jsonURL)!
                let date = self.df.date(from: jsonDate)!
                let newPhoto = EJSPhoto(title: title, explanation: explanation, date: date , url: url)
                self.photos.append(newPhoto)
            } catch {
                NSLog("Failed to do something with json \(error)")
                completion(error)
            }
            completion(nil)
            
        }.resume()
    }
    
    func fetchPhotoData(url: URL, completion: @escaping (Data?, Error?)->()) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching single photo(URL: \(url)) : \(error)")
                return
            }
            
            guard let data = data else { fatalError() }
            
            completion(data, nil)
        }.resume()
        
    }
    
    func fetchToday(completion: @escaping (Error?)->()) {
        fetchPhotoForDate(date: Date()) { (error) in
            if let error = error {
                NSLog("Error error : \(error)")
                completion(error)
            }
            completion(nil)
        }
    }
    
    func getDays(for month: Int, in year: Int) -> [Date] {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let days = (range.lowerBound ..< range.upperBound).compactMap { calendar.date(byAdding: .day, value: $0, to: date) }
        return days
    }
}
