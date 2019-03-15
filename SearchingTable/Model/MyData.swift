//
//  MyData.swift
//  SearchingTable
//
//  Created by Buse ERKUŞ on 4.03.2019.
//  Copyright © 2019 Buse ERKUŞ. All rights reserved.
//

import Foundation

enum Mode {
    case add
    case edit
}

struct MyData {
    
    var name: String = ""
    var age: Int = 18
    var gender: Bool = false // false = male, true = female
}
