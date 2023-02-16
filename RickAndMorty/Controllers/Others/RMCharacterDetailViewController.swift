//
//  RMCharacterDetail ViewController.swift
//  RickAndMorty
//
//  Created by Sam on 16/02/2023.
//

import UIKit

/// Controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    //MARK: - init
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
         super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

}