//
//  Question.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 2, 2020

import Foundation
import SwiftyJSON


class Question : NSObject, NSCoding{

    var label : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        label = json["label"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if label != nil{
        	dictionary["label"] = label
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		label = aDecoder.decodeObject(forKey: "label") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if label != nil{
			aCoder.encode(label, forKey: "label")
		}

	}

}
