//
//  MesurementView.swift
//  Weather
//
//  Created by Dat on 02/03/2025.
//

import SwiftUI

struct MesurementView: View {
    let color: Color = .gray
    let title: String
    let subtitle: String
    var image: Image?
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 70, height: 70)
                if let image {
                    image.imageScale(.large)
                        .font(.title)
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
}

struct MesurementView_Previews: PreviewProvider {
    static var previews: some View {
        MesurementView(title: "Min Temp", subtitle: "21°")
    }
}
