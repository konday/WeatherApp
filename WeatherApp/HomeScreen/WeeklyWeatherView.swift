//
//  WeeklykWeatherView.swift
//  WeatherApp
//
//  Created by Andrei Kondaurov on 11/7/24.
//

import UIKit

class WeeklyWeatherView: UIView {
    
    private let days = ["S", "M", "T", "W", "T", "F", "S"]
    private let temperatures = ["23°", "24°", "21°", "22°", "23°", "25°", "26°"]
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(stackView)
        
        for (index, day) in days.enumerated() {
            let dayTempStack = createDayTemperatureStack(day: day, temperature: temperatures[index])
            stackView.addArrangedSubview(dayTempStack)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func createDayTemperatureStack(day: String, temperature: String) -> UIStackView {
        let dayLabel = UILabel()
        dayLabel.text = day
        dayLabel.font = UIFont(name: "Inter", size: 18)
        dayLabel.textColor = .darkGray
        dayLabel.textAlignment = .center
        
        let temperatureLabel = UILabel()
        temperatureLabel.text = temperature
        temperatureLabel.font = UIFont(name: "Inter", size: 18)
        temperatureLabel.textColor = .white
        temperatureLabel.textAlignment = .center
        
        let dayTempStack = UIStackView(arrangedSubviews: [dayLabel, temperatureLabel])
        dayTempStack.axis = .vertical
        dayTempStack.alignment = .center
        dayTempStack.spacing = 4
        return dayTempStack
    }
}
