//
//  DownloadOperation.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/13/21.
//

import UIKit

//typealias DownloadCompletion = (UIImage?) -> ()
typealias DownloadCompletion = (Result<UIImage, Error>) -> ()

class ImageDownloadOperation: Operation {
    
    private let url: URL
    var callback: (Result<UIImage, Error>) -> ()
    
    init(url: URL) {
        self.url = url
        self.callback = {_ in}
        super.init()
    }
    
    override func main() {
        
        if isCancelled {
            return
        }
        
        guard let imageData = try? Data(contentsOf: url) else {
            return
        }
        
        if isCancelled {
            return
        }
        
        if !imageData.isEmpty, let image = UIImage(data: imageData) {
            FileHandler.handler.cacheImage(fileName: url.lastPathComponent, data: imageData)
            callback(.success(image))
        }
    }
    
    
}
