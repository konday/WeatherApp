//
//  DetailView.swift
//  WeatherApp
//
//  Created by Andrei Kondaurov on 11/9/24.
//
import UIKit

class WeatherDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeModel: HomeModel?
    
    private var weatherDetails: [WeatherDetail] = []
    
    init(homeModel: HomeModel) {
            self.homeModel = homeModel
            super.init(nibName: nil, bundle: nil)
            self.weatherDetails = [
                WeatherDetail(iconName: "cloud-sun-02", value: "\(homeModel.temp)°C", title: "Temperature"),
                WeatherDetail(iconName: "thermometer-03", value: "\(homeModel.feelTemperature)°C", title: "Feels like"),
                WeatherDetail(iconName: "wind-02", value: "\(homeModel.feelTemperature) km/h", title: "Wind"),
                WeatherDetail(iconName: "speedometer-02", value: "\(homeModel.feelTemperature) mb", title: "Pressure"),
                WeatherDetail(iconName: "droplets-02", value: "\(homeModel.feelTemperature)%", title: "Humidity"),
                WeatherDetail(iconName: "cloud-raining-05", value: "\(homeModel.feelTemperature)%", title: "Precipitation")
            ]
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherDetailCell.self, forCellWithReuseIdentifier: "WeatherDetailCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func didReceiveModel(_ model: SearchModel) {
            print("Recive: \(model.city)")
        }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailCell", for: indexPath) as! WeatherDetailCell
        let detail = weatherDetails[indexPath.item]
        cell.configure(with: detail)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let availableWidth = collectionView.frame.width - padding * 3
        let width = availableWidth / 2
        return CGSize(width: width, height: width)
    }
}
