//
//  SearchItem.swift
//  wakeithappn
//
//  Created by Gokhale, Salil (UK - London) on 6/7/18.
//  Copyright © 2018 Salil Gokhale. All rights reserved.
//

import Foundation

class SearchAddressItem: NSObject {
    var itemID: String
    var itemName: String
    
    init(itemID: String, itemName: String, itemDetails: String) {
        self.itemID = itemID
        self.itemName = itemName
    }
}
