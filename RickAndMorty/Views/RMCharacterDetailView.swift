//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Sam on 16/02/2023.
//

import UIKit

/// View for single character info
final class RMCharacterDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}
