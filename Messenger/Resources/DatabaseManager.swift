//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Jack on 20/06/2020.
//  Copyright © 2020 Jack Lee. All rights reserved.
//

import Foundation
import Firebase


final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}







//MARK: - Account Management

extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { (snapshot) in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
            
        }
        
    }
    
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName,
            ], withCompletionBlock: {error, _  in
                guard error == nil else {
                    print("failed to write to database")
                    completion(false)
                    return
                }
                completion(true)
        })
    }
    
}



struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profilePictureFileName: String {
        //jwz1101-hotmail-com_profile_picture.png
        return "\(safeEmail)_profile_picture.png"
    }
    
}




