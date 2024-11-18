//
//  FooterView.swift
//  WeatherApp
//
//  Created by Andrei Kondaurov on 11/8/24.
//
import UIKit

class FooterView: UIView {
    
    // MARK: - UI Elements
    
    let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "slider.horizontal.2.square"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        addSubview(leftButton)
        addSubview(pageControl)
        addSubview(rightButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            leftButton.centerYAnchor.constraint(equalTo: topAnchor, constant: 20),
                                  
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            rightButton.centerYAnchor.constraint(equalTo: topAnchor, constant: 20),
                                  
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: topAnchor, constant: 20)
        ])
    }
}


