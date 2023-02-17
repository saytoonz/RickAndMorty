//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Sam on 17/02/2023.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue     }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private  func addConstraints() {
        
    }
}
