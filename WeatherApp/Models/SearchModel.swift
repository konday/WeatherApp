//
//  SearchModel.swift
//  WeatherApp
//
//  Created by Andrei Kondaurov on 11/7/24.
//

import Foundation

struct SearchModel: Codable {
    
    
    
    let city: String
    let time: String
    let description: String
    let temperature: Int
    let highTemperature: Int
    let lowTemperature: Int
    var hourlyWeather: [String] = []
}
