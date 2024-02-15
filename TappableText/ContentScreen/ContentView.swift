//
//  ContentView.swift
//  TappableText
//
//  Created by Aleksei Kudriashov on 2/15/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel

    var body: some View {
        ZStack {
            FlexibleGrid {
                ForEach(viewModel.linguaTextModels, id: \.id) { linguaModel in
                    LinguaText(linguaModel: linguaModel) { modelId in
                        viewModel.handleViewAction(.didSelectLinguaModelWithId(modelId))
                    }
                }
            }
            .padding()
        }
    }

    init(viewModel: ContentViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
