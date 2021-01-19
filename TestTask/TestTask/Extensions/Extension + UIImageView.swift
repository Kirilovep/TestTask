//
//  Extenstion + UIImageView.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL, indicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            indicator.startAnimating()
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        indicator.stopAnimating()
                    }
                }
            }
        }
    }
}
