//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrei Kondaurov on 11/4/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var weatherView: HomeWeatherView = {
        let weatherView = HomeWeatherView()
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        return weatherView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(systemName: "slider.horizontal.2.square")
        button.setImage(icon, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(systemName: "list.bullet")
        button.setImage(icon, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        view.addSubview(weatherView)
        view.addSubview(footerView)
        
        footerView.addSubview(leftButton)
        footerView.addSubview(pageControl)
        footerView.addSubview(rightButton)
        
        weatherView.setupData()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 76),
            
            weatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            weatherView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            leftButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            leftButton.centerYAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
            
            rightButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            rightButton.centerYAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
            
            pageControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: footerView.topAnchor, constant: 20)
        ])
    }
    
    private func setupBackgroundImage() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "Sunny-1")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(backgroundImageView, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

