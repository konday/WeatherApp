import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    private var suggestions: [String] = [
        "Palm Beach, QLD Australia",
        "Palm Beach, FL United States",
        "Palm Bay, FL United States",
        "Palm Beach International Airport 1000 Palm Beach",
        "Palm Beach Gardens, FL United States",
        "Palm Beach County, FL United States",
        "West Palm Beach, FL United States",
        "Palm Beach Shores, FL United States",
        "Royal Palm Beach, FL United States",
        "North Palm Beach, FL United States"
    ]
    
    private var filteredSuggestions: [String] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        table.separatorStyle = .none
        return table
    }()
    
    private var viewModel: CityModel
    
//    init(viewModel: CityModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Weather"
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredSuggestions = []
            tableView.isHidden = true
            tableView.reloadData()
            return
        }
        
        filteredSuggestions = suggestions.filter { $0.lowercased().contains(searchText.lowercased()) }
        
        tableView.isHidden = filteredSuggestions.isEmpty
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSuggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let suggestion = filteredSuggestions[indexPath.row]
        let attributedText = NSMutableAttributedString(string: suggestion)
        
        if let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty {
            let range = (suggestion.lowercased() as NSString).range(of: searchText)
            attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: cell.textLabel?.font.pointSize ?? 17), range: range)
        }
        
        cell.textLabel?.attributedText = attributedText
        cell.textLabel?.textColor = .label
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSuggestion = filteredSuggestions[indexPath.row]
        searchController.searchBar.text = selectedSuggestion
        searchController.isActive = false
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
