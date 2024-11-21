//
//  Untitled.swift
//  WeatherApp
//
//  Created by Andrei Kondaurov on 11/7/24.
//
import UIKit

class WeatherViewController: UIViewController, HomeWeatherViewDelegate {
    
    var model: HomeModel? {
        didSet {
            guard isViewLoaded else { return }
            setupWeatherData()
        }
    }
    
    private lazy var weatherView: HomeWeatherView = {
        let view = HomeWeatherView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupSubviews()
        setupConstraints()
        

        if model != nil {
            setupWeatherData()
        }
    }
    
    func didTapInfoButton() {
        print(model!.feelTemperature)
        let WeatherDetailView = WeatherDetailViewController(homeModel: model!)
        //WeatherDetailView.data = model?
        navigationController?.pushViewController(WeatherDetailView, animated: true)
    }
    
    private func setupSubviews() {
        view.addSubview(weatherView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupWeatherData() {
        guard let model = model else { return }
        weatherView.setupData(model: model)
    }
}
