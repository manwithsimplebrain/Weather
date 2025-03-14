//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Dat Doan on 3/3/25.
//

import Foundation
import Factory
import FirebaseAnalytics
import CoreLocation
import Combine


class WeatherViewModel: ObservableObject {
    // Properties for UI
    @Published var weather: Weather?
    @Published var address: Address?
    @Published var backgroundImage: UIImage?
    @Published var showGuideView = false
    @Published var location: CLLocationCoordinate2D = .init()
    
    // Dependencies
    @Injected(\.weatherRepository) private var weatherRepository
    @Injected(\.geoRepository) private var geoRepository
    @Injected(\.locationService) private var locationService
    @Injected(\.trackingService) private var trackingService
    @Injected(\.storageService) private var storageService
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $location
            .removeDuplicates {
                $0.latitude == $1.latitude && $0.longitude == $1.longitude
            }
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink {[weak self] coordinate in
                Task {
                    do {
                        try await self?.fetchWeather(at: coordinate)
                    } catch {
                        print("Fetch weather failed: \(error)")
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func requestLocationPermission() {
        Task {
            do {
                let status = try await locationService.requestPermission()
                switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    await hiddenGuide()
                    try await requestCurrentLocation()
                case .denied:
                    await showGuide()
                default:
                    // show guide view
                    break
                }
            } catch {
                // FIXME: Handle error when request location permission
            }
        }
    }
    
    func requestCurrentLocation() async throws {
        let coordinate = try await locationService.requestCurrentLocation().coordinate
        print(coordinate)
        try await fetchWeather(at: coordinate)
    }
    
    func fetchWeather(at coordinate: CLLocationCoordinate2D) async throws {
        async let weatherTask = weatherRepository.fetchWeather(lat: coordinate.latitude, long: coordinate.longitude)
        async let addressTask = geoRepository.convert(lat: coordinate.latitude, long: coordinate.longitude)
        
        let (weather, address) = try await (weatherTask, addressTask)
        print("WEATHER: \(weather)")
        print("ADDRESS: \(address)")
        print("======+======+======+======+======+======+======+======+======")
        
        // fetch background image
        fetchBackgroundImage(name: weather.icon)
        
        await MainActor.run {
            self.weather = weather
            self.address = address
        }
    }
    
    @MainActor
    func showGuide() {
        showGuideView = true
    }
    
    @MainActor
    func hiddenGuide() {
        showGuideView = false
    }
    
    func fetchBackgroundImage(name: String?) {
        Task {
            guard let name else { return }
            let image = await storageService.fetchImage(name)
            await MainActor.run {
                backgroundImage = image
            }
        }
    }
}

extension WeatherViewModel {
    var lastUpdateAt: String {
        return L10n.lastUpdateAt
    }
    
    var todayWeather: String {
        return L10n.todayWeather
    }
    
    var temperature: String {
        return L10n.temperture
    }
    
    var humidity: String {
        return L10n.humidity
    }
    
    var windSpeed: String {
        return L10n.windSpeed
    }
    
    var pressure: String {
        return L10n.pressure
    }
    
    var weatherTab: String {
        return L10n.weather
    }
    
    var settingsTab: String {
        return L10n.settings
    }
    
    var place: String {
        return address?.city ?? address?.country ?? "Unknown"
    }
}


