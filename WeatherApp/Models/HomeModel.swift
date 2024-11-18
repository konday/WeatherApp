

import Foundation

struct HomeModel: Codable {
    let name: String
    let Region: String
    let Time: String
    let Icon: String
    let description: String
    let temp: Int
    let tempType: String
    let feelTemperature: Int
}

//cityNameLabel.text = "New York"
//cityRegionLabel.text = "NY, USA"
//cityTimeLabel.text = "10:00 AM"
//weatherIconImageView.image = UIImage(named: "Sunny")
//descriptionLabel.text = "Windy"
//tempLabel.text = "27"
//tempTypeLabel.text = "°C"
