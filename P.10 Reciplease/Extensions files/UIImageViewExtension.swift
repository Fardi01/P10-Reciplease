//
//  UIImageViewExtension.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 21/11/2021.
//

import Foundation
import UIKit

extension UIImageView {
    func getImage(with url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
