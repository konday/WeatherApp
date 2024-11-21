import Foundation

protocol FavoritesViewModelDelegate: AnyObject {
    func dataLoaded ()
}

class FavoritesViewModel {
    
    weak var delegate: FavoritesViewModelDelegate?
    
    var filter = ""
    
    private var networkconnect: Networkconnect!
    
    private var filteredData: [CityModel] = []
    
    var favoriteCities: [CityModel] = []
    
    
    init(networkconnect: Networkconnect) {
        self.networkconnect = networkconnect
    }
    
    func searchedData(data: String) {
        filter = data.lowercased()
        networkconnect.geocodingCity(city: data) {[weak self] citymodels, errorline in
            DispatchQueue.main.async {
                self?.filteredData = citymodels
                self?.delegate?.dataLoaded()
            }
        }
    }

    func getSuggestions() -> [CityModel] {
        return filter.isEmpty ? [] : filteredData
    }

    func addToFavorites(city: CityModel) {
        if !favoriteCities.contains(where: { $0.name == city.name }) {
            favoriteCities.append(city)
            saveFavoriteCities(cities: favoriteCities)
        }
    }
    
    func removeFavorites(index: Int) {
        favoriteCities.remove(at: index)
        saveFavoriteCities(cities: favoriteCities)
    }
    
    func saveFavoriteCities(cities: [CityModel]) {
        let fileURL = getDocumentsDirectory().appendingPathComponent("favorites.json")
        do {
            let data = try JSONEncoder().encode(cities)
            try data.write(to: fileURL)
        } catch {
            print("Error save: \(error)")
        }
    }

    func loadFavoriteCities() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("favorites.json")
        do {
            let data = try Data(contentsOf: fileURL)
            favoriteCities = try JSONDecoder().decode([CityModel].self, from: data)
        } catch {
            print("Error load: \(error)")
            favoriteCities = []
        }
    }
    
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
}
