import UIKit

class CityDetailViewController: UIViewController {
    
    private let city: CityModel
    private let cityModel: FavoritesViewModel
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(city: CityModel, cityModel: FavoritesViewModel) {
        self.city = city
        self.cityModel = cityModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        updateFavoriteButton()
    }
    
    private func setupLayout() {
        view.addSubview(cityNameLabel)
        view.addSubview(favoriteButton)
        
        cityNameLabel.text = city.name
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44)
        ])
        
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }
    
    @objc private func toggleFavorite() {
        if cityModel.favoriteCities.contains(where: { $0.name == city.name }) {
            cityModel.favoriteCities.removeAll { $0.name == city.name }
        } else {
            cityModel.addToFavorites(city: city)
        }
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        let isFavorite = cityModel.favoriteCities.contains(where: { $0.name == city.name })
        let starImage = isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: starImage), for: .normal)
    }
}
