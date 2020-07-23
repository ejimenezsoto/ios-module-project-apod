//
//  NetworkError.swift
//  AstronomyPictureOfTheDay
//
//  Created by Enzo Jimenez-Soto on 7/23/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badResponse, badData, errorDecoding
}
