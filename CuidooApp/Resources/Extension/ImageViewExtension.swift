//
//  ImageViewExtension.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 11/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  
  func setImage(url: URL?, completion: CompletionObject<UIImage?>? = nil) {
    kf.setImage(with: url) { result in
      switch result {
      case .success(let value):
        completion?(value.image)
      case .failure(_):
        completion?(nil)
      }
    }
  }
  
  func cancelDownload() {
    kf.cancelDownloadTask()
  }
}
