import UIKit

class FavoritesViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let favoritesModel: FavoritesViewModel
    private let favoritesView = FavoritesView()
    
    private var suggestions: [CityModel] = []
    private var searchText: String = ""

    override func loadView() {
        view = favoritesView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesView.favoritesTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesModel.delegate = self
        title = "Weather"
        setupDelegates()
        
    }
    
    init(favoritesModel: FavoritesViewModel) {
        self.favoritesModel = favoritesModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDelegates() {
        favoritesView.searchBar.delegate = self
        favoritesView.suggestionsTableView.delegate = self
        favoritesView.suggestionsTableView.dataSource = self
        favoritesView.favoritesTableView.delegate = self
        favoritesView.favoritesTableView.dataSource = self
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange text: String) {
        searchText = text
        suggestions = favoritesModel.searchedData(data: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchText = ""
        suggestions = []
        favoritesView.suggestionsTableView.isHidden = true
        favoritesView.suggestionsTableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == favoritesView.suggestionsTableView {
            return suggestions.count
        } else {
            return favoritesModel.favoriteCities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == favoritesView.favoritesTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell else {
                return UITableViewCell()
            }
            let city = favoritesModel.favoriteCities[indexPath.row]
            cell.configure(with: city)
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            let city = suggestions[indexPath.row]
            
            let fullText = "\(city.name), \(city.state ?? " "), \(city.country)"
            
            let attributedText = NSMutableAttributedString(string: fullText)

            if let range = fullText.lowercased().range(of: searchText.lowercased()) {
                let nsRange = NSRange(range, in: fullText)
                
                attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: nsRange)
            }
            
            cell.textLabel?.attributedText = attributedText
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == favoritesView.suggestionsTableView {
            let selectedCity = suggestions[indexPath.row]
            let detailVC = CityDetailViewController(city: selectedCity, cityModel: favoritesModel)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // Delete Favorites City
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == favoritesView.favoritesTableView {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
                guard let self = self else { return }
                self.favoritesModel.favoriteCities.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        return nil
    }
    
    // MARK: - Helpers
    
    private func getHighlightedText(for text: String, with query: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text.lowercased() as NSString).range(of: query.lowercased())
        if range.location != NSNotFound {
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: range)
        }
        return attributedString
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    func dataLoaded() {
        print("update")
        suggestions = favoritesModel.getSuggestions()
        favoritesView.suggestionsTableView.isHidden = suggestions.isEmpty
        favoritesView.suggestionsTableView.reloadData()
    }
}
