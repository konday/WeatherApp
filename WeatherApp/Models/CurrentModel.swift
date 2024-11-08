//
//  CurrentModel.swift
//  WeatherApp
//
//  Created by Andrei Kondaurov on 11/7/24.
//

import Foundation

struct CurrentModel: Codable {
       let weather: [Weather]
       let main: Main
       let name: String
   }

   // MARK: - Weather
   struct Weather: Codable {
       let main: String
       let description: String
   }

   // MARK: - Main
   struct Main: Codable {
       let temp: Double
       let feels_like: Double
       let temp_min: Double
       let temp_max: Double
   }


