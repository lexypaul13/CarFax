//
//  NetworkManger .swift
//  CarFax
//
//  Created by Alex Paul on 7/22/21.
//

import UIKit

class NetworkManger{
    
    static let sharedTask = NetworkManger()
    private let baseURL =  "https://carfax-for-consumers.firebaseio.com/assignment.json"
    let cache   = NSCache<NSString, UIImage>()

    init(){}
    
    
    private var jsonDecoder:JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    func getCars(completed:@escaping(Result<CFDataModel, CFError>)->Void){
        guard let url = URL(string: baseURL) else {
            //  completed(.failure(.invalidData))
            print(CFError.invaldURL)
            return
        }
        let task = URLSession.shared.dataTask(with: url){data, response, error in
            if let _ = error{
                //completed(.failure(.unableToComplete))
                print(CFError.unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                //  completed(.failure(.invalidResponse))
                print(CFError.invalidResponse)
                return
            }
            
            guard let data = data else{
                // completed(.failure(.invalidData))
                print(CFError.invalidData)
                return
            }
            
            do {
                let apiResponse = try self.jsonDecoder.decode(CFDataModel.self, from: data)
               // print(String.init(data: data, encoding: .utf8))
                completed(.success(apiResponse))
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) { 
        let cacheKey = NSString(string: urlString)
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.cache.setObject(image, forKey: cacheKey)
                completed(image)
            }
        }
        task.resume()
    }
    
}
