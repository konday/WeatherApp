//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrei Kondaurov on 11/4/24.
//

import UIKit

class HomeViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private let cities: [HomeModel] = [
        HomeModel(name: "New York", Region: "US, NY", Time: "10:30 PM", Icon: "Sunny", description: "Sunny", temp: 24, tempType: "°C", feelTemperature: 23),
        HomeModel(name: "London", Region: "UK", Time: "3:30 AM", Icon: "Sunny", description: "Sunny", temp: 18, tempType: "°C", feelTemperature: 23),
        HomeModel(name: "Paris", Region: "FR", Time: "4:30 AM", Icon: "Sunny", description: "Sunny", temp: 20, tempType: "°C", feelTemperature: 21)
    ]
    
    private var pageViewController: UIPageViewController!
    private var currentPage = 0
    
    private lazy var footerView: FooterView = {
          let footer = FooterView()
          footer.pageControl.numberOfPages = cities.count
          footer.pageControl.currentPage = currentPage
          footer.translatesAutoresizingMaskIntoConstraints = false
          return footer
      }()
    
    private lazy var setupPageController: UIPageViewController = {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        return pageViewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        view.addSubview(footerView)
        
        setupPageViewController()
        
        footerView.rightButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        footerView.pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        setupConstraints()
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
    
    private func setupPageViewController() {
        if let firstController = viewControllerAtIndex(index: currentPage) {
            setupPageController.setViewControllers([firstController], direction: .forward, animated: true, completion: nil)
        }
        
        addChild(setupPageController)
        view.addSubview(setupPageController.view)
        setupPageController.didMove(toParent: self)
        
        setupPageController.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func viewControllerAtIndex(index: Int) -> UIViewController? {
        guard index >= 0 && index < cities.count else { return nil }
        
        let weatherController = WeatherViewController()
        weatherController.model = cities[index]
        return weatherController
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 76),
            
            setupPageController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            setupPageController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            setupPageController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            setupPageController.view.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ])
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = currentPage
        index -= 1
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = currentPage
        index += 1
        return viewControllerAtIndex(index: index)
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentViewController = pageViewController.viewControllers?.first as? WeatherViewController,
           let index = cities.firstIndex(where: { $0.name == currentViewController.model?.name }) {
            footerView.pageControl.currentPage = index
            currentPage = index
        }
    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        let selectedIndex = sender.currentPage
        
        let direction: UIPageViewController.NavigationDirection = selectedIndex > currentPage ? .forward : .reverse
        
        if let viewController = viewControllerAtIndex(index: selectedIndex) {
            setupPageController.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
        }
        currentPage = selectedIndex
    }
    
    @objc private func searchAction() {
        //let networkConnection = Networkconnect()
        //let viewModel = SearchViewModel(networkconnect: networkConnection)
        let networkConnection = Networkconnect()
        let viewModel = FavoritesViewModel(networkconnect: networkConnection)
        let favoritesViewController = FavoritesViewController(favoritesModel: viewModel)
        navigationController?.pushViewController(favoritesViewController, animated: true)
    }
}
