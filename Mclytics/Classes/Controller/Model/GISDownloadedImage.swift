//
//  FGISDownloadedImage.swift
//  TestSpatialite
//
//  Created by Gaurav on 29/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation

class GISDownloadedImage {
    
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
