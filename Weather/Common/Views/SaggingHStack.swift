//
//  SaggingHStack.swift
//  Weather
//
//  Created by Dat Doan on 12/3/25.
//

import SwiftUI

struct SaggingLayout: Layout {
    let maxYOffset: CGFloat
    let maxRotation: Double
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let totalWidth = subviews.reduce(0) { $0 + $1.sizeThatFits(proposal).width }
        let maxHeight = subviews.map { $0.sizeThatFits(proposal).height }.max() ?? 0
        return CGSize(width: totalWidth, height: maxHeight + maxYOffset)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let centerIndex = (subviews.count - 1) / 2
        let spacing: CGFloat = 10
        var xOffset: CGFloat = 0

        for (index, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(proposal)
            
            let yOffset = -pow(CGFloat(index - centerIndex), 2) * (maxYOffset / pow(CGFloat(centerIndex), 2))
            let rotation = -maxRotation * Double(abs(index - centerIndex)) / Double(centerIndex)

            let position = CGPoint(
                x: bounds.minX + xOffset + size.width / 2,
                y: bounds.midY + yOffset
            )

            subview.place(at: position, anchor: .center, proposal: ProposedViewSize(size))
            
            xOffset += size.width + spacing
        }
    }
}

struct SaggingHStack: View {
    let items = Array(1...5)
    
    var body: some View {
        SaggingLayout(maxYOffset: 50, maxRotation: 15) {
            ForEach(items, id: \.self) { item in
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 80, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
    }
}

#Preview {
    SaggingHStack()
}
