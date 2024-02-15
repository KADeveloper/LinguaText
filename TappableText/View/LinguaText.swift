//
//  LinguaText.swift
//  TappableText
//
//  Created by Aleksei Kudriashov on 2/15/24.
//

import SwiftUI

struct LinguaText: View {
    @State private var offset: Double = .zero

    private let overlayTextPadding: Double = 6

    let linguaModel: LinguaTextModel
    let onTapAction: (_ id: String) -> Void

    var body: some View {
        Text(linguaModel.text)
            .foregroundStyle(linguaModel.isSelected ? Color.orange : Color.black)
            .overlay(
                GeometryReader { textProxy in
                    HStack {
                        if linguaModel.isSelected,
                           let translation = linguaModel.translation {
                            HStack {
                                Text(translation)
                                    .padding(overlayTextPadding)
                                    .onChangeSize { overlaySize in
                                        guard overlaySize.width > textProxy.size.width else { return }

                                        let globalFrame = textProxy.frame(in: .global)

                                        let screenWidth = UIScreen.main.bounds.width
                                        let potentialMinXposition = globalFrame.midX - overlaySize.width / 2
                                        let potentialMaxXposition = globalFrame.midX + overlaySize.width / 2

                                        if potentialMinXposition < 0 {
                                            offset = -textProxy.safeAreaInsets.leading
                                        } else if potentialMaxXposition > screenWidth {
                                            offset = screenWidth - (globalFrame.minX + overlaySize.width)
                                            print(offset)
                                        } else {
                                            offset = textProxy.size.width / 2 - overlaySize.width / 2
                                        }
                                    }
                            }
                            .background(Color.mint)
                            .cornerRadius(10)
                            .fixedSize()
                        }
                    }
                    .offset(x: offset,
                            y: -(textProxy.size.height + 2 * overlayTextPadding))
                }
            )
            .onTapGesture {
                onTapAction(linguaModel.id)
            }
    }
}
