//
//  SearchLocationView.swift
//  Weather
//
//  Created by Dat Doan on 14/3/25.
//

import SwiftUI
import MapKit

struct SearchLocationView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedLocation: CLLocationCoordinate2D
    @StateObject private var viewModel = LocationSearchViewModel()
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.searchResults) { place in
                MapMarker(coordinate: place.placemark.coordinate, tint: .blue)
            }
            .ignoresSafeArea()
            
            VStack {
                TextField("Enter location...", text: $searchText, onCommit: {
                    viewModel.search(query: searchText)
                })
                .textFieldStyle(.plain)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.searchResults) { item in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name ?? "No name")
                                    .font(.headline)
                                    .lineLimit(1)
                                Text(item.placemark.title ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                            .onTapGesture {
                                viewModel.selectLocation(item)
                                selectedLocation = item.placemark.coordinate
                                dismiss()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, viewModel.searchResults.isEmpty ? 0 : 16)
                    .padding(.vertical, viewModel.searchResults.isEmpty ? 0 : 10)
                    .background(.ultraThinMaterial)
                    
                }
                .frame(maxHeight: 250)
                .fixedSize(horizontal: false, vertical: true)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }
            .padding()
            
        }
    }
}

#Preview {
    SearchLocationView(
        selectedLocation:
                .constant(CLLocationCoordinate2D(latitude: 0, longitude: 0))
    )
}
