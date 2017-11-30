//
//  jsonBasedModel.swift
//  MachineTest
//
//  Created by Ashin Asok on 29/11/17.
//  Copyright © 2017 Ashin Asok. All rights reserved.
//

import Foundation

class jsonBasedModel{
    
    var header : String
    var element : [String]
    var imageUrl : [String]
    
    init(header:String,element:[String],imageUrl:[String]) {
        self.header = header
        self.element = element
        self.imageUrl = imageUrl
    }
}
