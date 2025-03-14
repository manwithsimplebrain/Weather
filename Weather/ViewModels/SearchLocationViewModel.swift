//
//  SearchLocationViewModel.swift
//  Weather
//
//  Created by Dat Doan on 14/3/25.
//

import Foundation
import MapKit


class LocationSearchViewModel: ObservableObject {
    @Published var searchResults: [MKMapItem] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 10.7769, longitude: 106.7009),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    func search(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Lỗi tìm kiếm: \(error?.localizedDescription ?? "Không rõ lỗi")")
                return
            }

            DispatchQueue.main.async {
                self.searchResults = response.mapItems
            }
        }
    }

    func selectLocation(_ mapItem: MKMapItem) {
        let coordinate = mapItem.placemark.coordinate
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        }
    }
}

extension MKMapItem: @retroactive Identifiable {
    public var id: String {
        self.placemark.name ?? UUID().uuidString
    }
}
