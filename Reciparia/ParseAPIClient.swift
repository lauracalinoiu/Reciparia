//
//  ParseAPIClient.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 05/01/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import Foundation
import Parse

class ParseAPIClient{

    let NETWORK_INACCESSIBLE = "The network was inaccesible"
    let questionQueryLimit = 10
    
    func getQuestionsWithLimit(completionHandler: (result: [Recipe]!, error: String?) -> Void){
        let query = PFQuery(className: "Recipe")
        query.limit = questionQueryLimit
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objectsUnwrapped = objects as? [Recipe]{
                    completionHandler(result: objectsUnwrapped, error: nil)
                }
            } else {
                completionHandler(result: nil, error: self.NETWORK_INACCESSIBLE)
            }
        }
    }
    
    class var sharedInstance: ParseAPIClient{
        struct Static{
            static let instance: ParseAPIClient = ParseAPIClient()
        }
        return Static.instance
    }

}