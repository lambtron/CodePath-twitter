//
//  Tweet.swift
//  twitter
//
//  Created by Andy Jiang on 10/31/16.
//  Copyright © 2016 andyjiang. All rights reserved.
//

import Foundation

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweetsCount: Int = 0
    var likesCount: Int = 0
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetsCount = (dictionary["retweet_count"] as? Int) ?? 0
        likesCount = (dictionary["favourites_count"] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
