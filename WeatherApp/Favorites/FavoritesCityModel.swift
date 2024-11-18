import Foundation

protocol FavoritesViewModelDelegate: AnyObject {
    func dataLoaded ()
}

class FavoritesViewModel {
    
    var filter = ""
    
    weak var delegate: FavoritesViewModelDelegate?
    
    private var networkconnect: Networkconnect!
    
    private var filteredData: [CityModel] = []
    
    var favoriteCities: [CityModel] = [
        CityModel(name: "London", lat: 51.5156177, lon: -0.0919983, country: "GB", state: "England"),
        CityModel(name: "New York", lat: 40.7127281, lon: -74.0060152, country: "US", state: "New York"),
        CityModel(name: "Los Angeles", lat: 34.052235, lon: -118.243683, country: "US", state: "California"),
        CityModel(name: "Berlin", lat: 52.520008, lon: 13.404954, country: "DE", state: "Berlin"),
        CityModel(name: "Tokyo", lat: 35.689487, lon: 139.691711, country: "JP", state: "Tokyo")]
    
    private var allCities: [CityModel] = [
        CityModel(name: "Paris", lat: 48.8566, lon: 2.3522, country: "FR", state: "Ile-de-France"),
        CityModel(name: "Sydney", lat: -33.8688, lon: 151.2093, country: "AU", state: "New South Wales"),
        CityModel(name: "Toronto", lat: 43.65107, lon: -79.347015, country: "CA", state: "Ontario"),
        CityModel(name: "Mumbai", lat: 19.07609, lon: 72.877426, country: "IN", state: "Maharashtra"),
        CityModel(name: "Cape Town", lat: -33.92487, lon: 18.424055, country: "ZA", state: "Western Cape"),
        CityModel(name: "São Paulo", lat: -23.55052, lon: -46.633308, country: "BR", state: "São Paulo"),
        CityModel(name: "Shanghai", lat: 31.230391, lon: 121.473701, country: "CN", state: "Shanghai"),
        CityModel(name: "Moscow", lat: 55.755825, lon: 37.617298, country: "RU", state: "Moscow"),
        CityModel(name: "Rome", lat: 41.902782, lon: 12.496366, country: "IT", state: "Lazio"),
        CityModel(name: "Seoul", lat: 37.566536, lon: 126.977966, country: "KR", state: "Seoul")
    ]
    
    init(networkconnect: Networkconnect) {
        self.networkconnect = networkconnect
    }
    
    func searchedData(data: String) -> [CityModel] {
        filter = data.lowercased()
        networkconnect.geocodingCity(city: data) {[weak self] citymodels, errorline in
            DispatchQueue.main.async {
                self?.filteredData = citymodels
                self?.delegate?.dataLoaded()
            }
        }
        print("5")
        return filter.isEmpty ? [] : filteredData
    }

    func getSuggestions() -> [CityModel] {
        return filter.isEmpty ? [] : filteredData
    }

    func addToFavorites(city: CityModel) {
        if !favoriteCities.contains(where: { $0.name == city.name }) {
            favoriteCities.append(city)
        }
    }
}
