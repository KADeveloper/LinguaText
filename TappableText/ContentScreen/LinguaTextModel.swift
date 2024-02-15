//
//  LinguaTextModel.swift
//  TappableText
//
//  Created by Aleksei Kudriashov on 2/15/24.
//

import Foundation

struct LinguaTextModel: Identifiable {
    let id: String = UUID().uuidString

    let text: String
    let translation: String?

    var isSelected: Bool = false
}
