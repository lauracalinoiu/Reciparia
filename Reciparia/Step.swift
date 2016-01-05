//
//  Step.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 28/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import Foundation
import Parse

class Step: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return "Step"
    }
    
    @NSManaged var text: String?
}
