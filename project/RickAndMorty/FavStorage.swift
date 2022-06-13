//
//  FavStorage.swift
//  RickAndMorty
//
//  Created by Marina Roshchupkina on 13.06.2022.
//

import Foundation
import UIKit
class Storage {
    private init() {}
    
    static var shared = Storage()
    
    var favCharacters = [Character]()
    var favImages = [UIImage]()
    
    func getFavs()
    {
        if let storedObject: Data = UserDefaults.standard.data(forKey: "favCharacters")
        {
            do
            {
                let favs = try PropertyListDecoder().decode([Character].self, from: storedObject)
                Storage.shared.favCharacters = favs
                appLogger.logger.log(level: .info, message: "loading characters")
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
    }
    func addFavs()
    {
        do
        {
            UserDefaults.standard.set(try PropertyListEncoder().encode(Storage.shared.favCharacters), forKey: "favCharacters")
            UserDefaults.standard.synchronize()
            appLogger.logger.log(level: .info, message: "saving character")
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    func addImages() {
        try? UserDefaults.standard.set(images: Storage.shared.favImages, forKey: "favImages")
        UserDefaults.standard.synchronize()
        appLogger.logger.log(level: .info, message: "saving images")
        
        
    }
    
    func getImages() {
        
        let loadedImages = try? UserDefaults.standard.images(forKey: "favImages")
        Storage.shared.favImages = loadedImages ?? []
        appLogger.logger.log(level: .info, message: "loading images")
        
    }
    
}

extension UserDefaults {
    func set(image: UIImage?, quality: CGFloat = 0.5, forKey defaultName: String) {
        guard let image = image else {
            set(nil, forKey: defaultName)
            return
        }
        set(image.jpegData(compressionQuality: quality), forKey: defaultName)
    }
    func image(forKey defaultName:String) -> UIImage? {
        guard
            let data = data(forKey: defaultName),
            let image = UIImage(data: data)
        else  { return nil }
        return image
    }
    func set(images value: [UIImage]?, forKey defaultName: String) throws {
        guard let value = value else {
            removeObject(forKey: defaultName)
            return
        }
        try set(NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false), forKey: defaultName)
    }
    func images(forKey defaultName: String) throws -> [UIImage] {
        guard let data = data(forKey: defaultName) else { return [] }
        
        let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        return object as? [UIImage] ?? []
    }
}

