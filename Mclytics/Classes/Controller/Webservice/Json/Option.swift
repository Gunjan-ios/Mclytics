//
//  Option.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 2, 2020

import Foundation
import SwiftyJSON


class Option : NSObject, NSCoding{

    var checked : Bool!
    var label : String!
    var selected : Bool!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        checked = json["checked"].boolValue
        label = json["label"].stringValue
        selected = json["selected"].boolValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if checked != nil{
        	dictionary["checked"] = checked
        }
        if label != nil{
        	dictionary["label"] = label
        }
        if selected != nil{
        	dictionary["selected"] = selected
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		checked = aDecoder.decodeObject(forKey: "checked") as? Bool
		label = aDecoder.decodeObject(forKey: "label") as? String
		selected = aDecoder.decodeObject(forKey: "selected") as? Bool
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if checked != nil{
			aCoder.encode(checked, forKey: "checked")
		}
		if label != nil{
			aCoder.encode(label, forKey: "label")
		}
		if selected != nil{
			aCoder.encode(selected, forKey: "selected")
		}

	}

}
