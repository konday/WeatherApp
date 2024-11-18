import UIKit

protocol HomeWeatherViewDelegate: AnyObject {
    func didTapInfoButton()
}

class HomeWeatherView: UIView {
    
    weak var delegate: HomeWeatherViewDelegate?
    
    private var cityNameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "Inter", size: 32)
        name.text = ""
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private var cityRegionLabel: UILabel = {
        let region = UILabel()
        region.font = UIFont(name: "Inter", size: 20)
        region.text = ""
        region.translatesAutoresizingMaskIntoConstraints = false
        return region
    }()
    
    private var cityTimeLabel: UILabel = {
        let time = UILabel()
        time.font = UIFont(name: "Inter", size: 20)
        time.text = ""
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    private var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont(name: "Inter", size: 14)
        description.text = ""
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private var tempLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: "Inter", size: 96)
        temp.text = "25 °C"
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private var tempTypeLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: "Inter", size: 55)
        temp.text = "°C"
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var temperatureStackView: UIStackView = {
           let stackView = UIStackView(arrangedSubviews: [tempLabel, tempTypeLabel])
           stackView.axis = .horizontal
           stackView.alignment = .top
           stackView.spacing = 16
           stackView.translatesAutoresizingMaskIntoConstraints = false
           return stackView
       }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("More info", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter", size: 16)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var weeklyView: weeklyWeatherView = {
        let weeklyView = weeklyWeatherView()
        weeklyView.translatesAutoresizingMaskIntoConstraints = false
        return weeklyView
    }()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        addSubview(cityNameLabel)
        addSubview(cityRegionLabel)
        addSubview(cityTimeLabel)
        addSubview(weatherIconImageView)
        addSubview(descriptionLabel)
        addSubview(temperatureStackView)
        addSubview(infoButton)
        addSubview(weeklyView)
    }
    
    func setupData(model: HomeModel) {
        cityNameLabel.text = model.name
        cityRegionLabel.text = model.Region
        cityTimeLabel.text = model.Time
        weatherIconImageView.image = UIImage(named: "\(model.Icon)")
        descriptionLabel.text = model.description
        tempLabel.text = String(model.temp)
        tempTypeLabel.text = model.tempType
        }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 36),
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cityRegionLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 8),
            cityRegionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cityTimeLabel.topAnchor.constraint(equalTo: cityRegionLabel.bottomAnchor, constant: 8),
            cityTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            weatherIconImageView.topAnchor.constraint(equalTo: cityTimeLabel.bottomAnchor, constant: 20),
            weatherIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 80),  // Ширина 80
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 80),
            
            descriptionLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 4),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            temperatureStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            temperatureStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            infoButton.topAnchor.constraint(equalTo: temperatureStackView.bottomAnchor, constant: 104),
            infoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 120),
            infoButton.heightAnchor.constraint(equalToConstant: 43),
            
            weeklyView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weeklyView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    @objc private func infoButtonTapped() {
        delegate?.didTapInfoButton()
    }
}
