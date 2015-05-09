//
//  SMPost.swift
//  DearDiary
//
//  Created by Matthew Finlayson on 5/8/15.
//  Copyright (c) 2015 Cesare Rocchi. All rights reserved.
//

import Foundation

class SMPost: BAAObject {
    var postTitle: String!
    var postBody: String!
    
    override init(dictionary: [NSObject : AnyObject]!) {
        super.init(dictionary: dictionary)
        if let
            actualPostTitle = dictionary["postTitle"] as? String,
            actualPostBody = dictionary["postBody"] as? String {
                postTitle = actualPostTitle
                postBody = actualPostBody
        }
    }
    
    override func collectionName() -> String! {
        return "document/memos"
    }
    
    
    
}
