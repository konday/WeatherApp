//
//  Networkconnect.swift
//  PASV_WeatherForcast
//
//  Created by Andrei Kondaurov on 10/30/24.
//
//let apiKey = "0243d30fc76cc8453d3cd7015f2dce14"
//let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=\(name)&limit=1&appid=\(apiKey)"
//let urlString1 = "https://api.openweathermap.org/data/2.5/weather?lat=\(cityInfo.lat)&lon=\(cityInfo.lon)&appid=\(apiKey)"

import Foundation

class Networkconnect {
    
    let apiKey = "0243d30fc76cc8453d3cd7015f2dce14"
    
    func geocodingCity(city: String, completionHandler: @escaping (([CityModel], String?) -> Void)) {
        
        let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Error URl")
            completionHandler([], "Error URl")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error Task")
                completionHandler([], error.localizedDescription)
                return
            }
        
            guard let data = data else {
                print("Error Data")
                completionHandler([], "Error Data")
                return
            }
            
            do {
               // print("JSON String: \(String(describing: String(data: data, encoding: .utf8)))")
                let cityData = try JSONDecoder().decode([CityModel].self, from: data)
                completionHandler(cityData, nil)
            } catch {
                print("Error JSON")
                completionHandler([], "Error JSON")
            }
        }
        
        task.resume()
    }
    
    func currentWeather(data: CityModel?) {
        
        if let cityInfo = data {
            print("data complete current")
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(cityInfo.lat)&lon=\(cityInfo.lon)&appid=\(apiKey)"
            guard let url = URL(string: urlString) else {
                print("error URL")
                return
            }
            let currentTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Erorr task current")
                }
                if let data = data {
                    do {
                        let currentJSON = try JSONDecoder().decode(CurrentModel.self, from: data)
                        print("Current \(currentJSON)")
                    } catch {
                        print("error JSON current")
                    }
                }
            }
            currentTask.resume()
        } else {
            print("data error current")
        }
        
    }
    
}
