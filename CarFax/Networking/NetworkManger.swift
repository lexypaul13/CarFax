//
//  NetworkManger .swift
//  CarFax
//
//  Created by Alex Paul on 7/22/21.
//

import Foundation

class NetworkManger{
    
    static let sharedTask = NetworkManger()
    private let baseURL =  "https://carfax-for-consumers.firebaseio.com/assignment.json"
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
                print(String.init(data: data, encoding: .utf8))
               // completed(.success(apiResponse!))
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    
}
