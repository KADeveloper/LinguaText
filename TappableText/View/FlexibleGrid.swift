//
//  FlexibleGrid.swift
//  TappableText
//
//  Created by Aleksei Kudriashov on 2/15/24.
//

import SwiftUI

struct FlexibleGrid: Layout {
    private let spacing: Double = 4

    struct Cache {
        var gridWidth: Double = .zero
        var sizes: [CGSize] = []
    }

    func makeCache(subviews: Subviews) -> Cache {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return Cache(sizes: sizes)
    }

    func updateCache(_ cache: inout Cache, subviews: Subviews) {
        cache.sizes = subviews.map { $0.sizeThatFits(.unspecified) }
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout (Cache)) -> CGSize {
        guard let proposalWidth = proposal.width,
              !subviews.isEmpty else { return .zero }

        let subviewHeight = cache.sizes.map { $0.height }.max() ?? .zero

        var subviewsWidthSum: Double = .zero

        let combinedSize = cache.sizes.reduce(CGSize.zero) { currentSize, subviewSize in
            let width: Double
            let height: Double

            if currentSize.width + subviewSize.width + spacing <= proposalWidth {
                width = currentSize.width + subviewSize.width + spacing
            } else {
                width = currentSize.width
            }

            subviewsWidthSum += subviewSize.width

            let line = subviewsWidthSum / width

            if line > 0 {
                height = line.rounded(.up) * subviewHeight
            } else {
                height = subviewHeight
            }

            cache.gridWidth = width

            return CGSize(width: width,
                          height: height)
        }

        return combinedSize
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout (Cache)) {
        guard !bounds.minX.isNaN,
              !bounds.minY.isNaN else { return }

        var x = bounds.minX
        var y = bounds.minY

        for index in subviews.indices {
            let subviewSize = cache.sizes[index]

            if x + subviewSize.width + spacing > cache.gridWidth + bounds.minX {
                x = bounds.minX
                y += subviewSize.height
            }

            subviews[index]
                .place(
                    at: CGPoint(x: x,
                                y: y),
                    anchor: .topLeading,
                    proposal: ProposedViewSize(cache.sizes[index])
                )

            if x + subviewSize.width + spacing > cache.gridWidth + bounds.minX {
                x = bounds.minX
                y += subviewSize.height
            } else {
                x += subviewSize.width + spacing
            }
        }
    }
}
