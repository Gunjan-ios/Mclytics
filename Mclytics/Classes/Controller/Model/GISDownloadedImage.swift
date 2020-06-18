//
//  FGISDownloadedImage.swift
//  TestSpatialite
//
//  Created by Gaurav on 29/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class GISDownloadedImage {
    internal init(size: String?, name: String?, path: String?, imageData: Data?, type: String?) {
        self.size = size
        self.name = name
        self.path = path
        self.imageData = imageData
        self.type = type
    }
    
    
    var size: String?
    var name: String?
    var path: String?
    var imageData:Data?
    var type:String?
    var isFromTable = false
    
    init(pName:String?,pSize: String?, pPath:String?){
        self.name = pName
        self.size = pSize
        self.path = pPath
    }
    
}
struct AGImageInfo {
    var fileName: String
    var type: String
    var data: Data
}
