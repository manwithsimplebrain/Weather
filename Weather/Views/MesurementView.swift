//
//  MesurementView.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import SwiftUI

struct MesurementView: View {
    let color: Color = .secondary
    let title: String
    let subtitle: String
    var image: Image?
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 60, height: 60)
                if let image {
                    image.imageScale(.medium)
                        .font(.title)
                }
            }
            .background(.ultraThinMaterial)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Text(subtitle)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
        
    }
}

struct MesurementView_Previews: PreviewProvider {
    static var previews: some View {
        MesurementView(
            title: "Min Temp",
            subtitle: "21°",
            image: Image(systemName: "thermometer")
        )
    }
}
