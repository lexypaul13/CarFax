//
//  SaveData.swift
//  CarFax
//
//  Created by Alex Paul on 7/26/21.
//

import Foundation

enum SaveActionType {
    case add
    case remove
}

enum SaveManger{
    static private let defaults = UserDefaults.standard
    
    enum Keys{
        static let favorites = "favorites"
        static let mostRecent = "mostRecent"
    }
    
    static func updateWith(favorite: Listing, actionType: SaveActionType,key: String, completed: @escaping (CFError?) -> Void) {
        collectFavorties { result in
            
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.duplicateShow)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                    
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.make == favorite.make } ///deletes user
                }
                
                completed(save(favorites: retrievedFavorites, key: key))
                
            case .failure(let error):
                completed(error)
            }
        }
        
    }
    
    static func collectFavorties(completed:@escaping(Result<[Listing], CFError>)->Void){
        guard let favoriteData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Listing].self, from: favoriteData)
            completed(.success(favorites))
        } catch{
            completed(.failure(.unableToComplete))
        }
        
    }
    
    static func collectRecent(completed:@escaping(Result<[Listing], CFError>)->Void){
        guard let favoriteData = defaults.object(forKey: Keys.mostRecent) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Listing].self, from: favoriteData)
            completed(.success(favorites))
        } catch{
            completed(.failure(.unableToComplete))
        }
        
    }
    
    static func save (favorites: [Listing],key :String)->CFError?{
        do {
            let encoder = JSONEncoder()
            let encodedFavorite = try encoder.encode(favorites)
            defaults.setValue(encodedFavorite, forKey: key)
            return nil
        }
        catch {
            return .saveFailure
        }
    }
    
}
