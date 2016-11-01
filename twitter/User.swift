//
//  User.swift
//  twitter
//
//  Created by Andy Jiang on 10/31/16.
//  Copyright © 2016 andyjiang. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var bio: String?
    var dictionary: NSDictionary?
    
    static let userDidLogoutNotification = Notification.Name("UserDidLogout")
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_immage_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        bio = dictionary["description"] as? String
        
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if User._currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    User._currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set (user) {
            User._currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
