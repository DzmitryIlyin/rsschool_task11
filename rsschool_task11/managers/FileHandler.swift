//
//  FileManager.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/13/21.
//

import UIKit

class FileHandler {
    
    static let handler = FileHandler()
    
    private init() {}
    
    private let imageDownloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "File download queue"
        queue.qualityOfService = .background
        return queue
    }()
    
    lazy var imageCache = {
        loadCache()
    }()
    
    private func loadCache() -> [String:String] {
        return [:]
    }
    
    var imagesDownloadTasks: [IndexPath : Operation] = [:]
    
    func downloadImageWith(urlString: String, for imageView: UIImageView, for indexPath: IndexPath) {
                
        guard let url = URL(string: urlString) else {
            return
        }
        
        let imageFileName = url.lastPathComponent
        
        if let cachedImage = getCachedImage(fileName: imageFileName) {
            imageView.image = cachedImage
            imageView.setNeedsLayout()
            imageView.layoutIfNeeded()
            return
        }
        
        guard imagesDownloadTasks[indexPath] == nil else {
            return
        }
        
        let operation = ImageDownloadOperation(url: url)
        imagesDownloadTasks[indexPath] = operation
        
        operation.completionBlock = {
            if operation.isCancelled {
                return
            }
        }
        
        operation.callback = {[weak self] result in
            DispatchQueue.main.async {
                self?.imagesDownloadTasks.removeValue(forKey: indexPath)
                switch result {
                case .success(let image):
                    imageView.image = image
                default:
                    print("error")
                }
            }
        }
        
        imagesDownloadTasks[indexPath] = operation
        imageDownloadQueue.addOperation(operation)
    }
    
    func cancelImageDownload(indexPath: IndexPath) {
        let operation = imagesDownloadTasks[indexPath]
        if operation != nil {
            operation?.cancel()
        }
        
        imagesDownloadTasks.removeValue(forKey: indexPath)
    }
    
    private func getFileNameFrom(urlString: String) -> String {
        return URL(string: urlString)!.lastPathComponent
    }
    
    func getCachedImage(fileName: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: url.path) {
            print("I'M FROM CACHE")
            return UIImage(contentsOfFile: url.path)
        }
        return nil
    }
    
    func cacheImage(fileName: String, data: Data) {
        do {
            let savedURL = getDocumentsDirectory().appendingPathComponent(fileName)
            try data.write(to: savedURL)
        } catch {
            print ("file error: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func suspendImageDownloadQueue() {
        imageDownloadQueue.isSuspended = true
    }
    
    func resumeImageDownloadQueue() {
        imageDownloadQueue.isSuspended = false
    }

}
