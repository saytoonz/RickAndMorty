//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Sam on 03/02/2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
