//
//  CityModel.swift
//  WeatherApp
//
//  Created by Andrei Kondaurov on 11/7/24.
//

import Foundation

struct CityModel: Codable {
    let name: String
    let lat: Float
    let lon: Float
    let country: String
}
