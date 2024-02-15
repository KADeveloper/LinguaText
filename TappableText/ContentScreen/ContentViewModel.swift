//
//  ContentViewModel.swift
//  TappableText
//
//  Created by Aleksei Kudriashov on 2/15/24.
//

import Foundation

final class ContentViewModel: ObservableObject {
    enum ViewAction {
        case didSelectLinguaModelWithId(_ id: String)
    }

    @Published var linguaTextModels: [LinguaTextModel]

    init() {
        let textComponents = "En un valle rodeado de altas montañas, el pueblo de Sierra Verde despertaba al amanecer con el canto de los pájaros. Las calles empedradas resonaban con los pasos de los primeros habitantes que salían a comenzar sus labores, mientras el aroma del pan recién horneado llenaba el aire, prometiendo un día lleno de vida y trabajo en armonía con la naturaleza."
            .components(separatedBy: .whitespaces)

        linguaTextModels = textComponents.enumerated().map { index, word in
            LinguaTextModel(text: word,
                            translation: word == "pueblo" ? "town" : "Word\(index + 1)")
        }
    }

    func handleViewAction(_ action: ViewAction) {
        switch action {
        case .didSelectLinguaModelWithId(let id):
            for (index, model) in linguaTextModels.enumerated() {
                if model.id == id {
                    linguaTextModels[index].isSelected.toggle()
                } else {
                    linguaTextModels[index].isSelected = false
                }
            }
        }
    }
}
