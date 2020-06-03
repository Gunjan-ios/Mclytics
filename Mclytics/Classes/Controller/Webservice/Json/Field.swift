//
//  Field.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 2, 2020

import Foundation
import SwiftyJSON


class Field : NSObject, NSCoding{

    var accept : String!
    var alias : JSON!
    var answers : [Answer]!
    var carry : String!
    var carryforwardsource : Int!
    var checkdns : Bool!
    var disabled : Bool!
    var fields : [JSON]!
    var formId : Int!
    var helpText : JSON!
    var id : String!
    var inline : Bool!
    var inputType : String!
    var intro : String!
    var label : String!
    var max : JSON!
    var maxSize : JSON!
    var min : JSON!
    var minSize : JSON!
    var multiple : Bool!
    var number : String!
    var options : [Option]!
    var pattern : JSON!
    var placeholder : JSON!
    var predefinedValue : JSON!
    var questions : [Question]!
    var ranks : Int!
    var readOnly : Bool!
    var required : Bool!
    var showLabel : Bool!
    var shuffle : Bool!
    var side1 : String!
    var side2 : String!
    var size : String!
    var text : String!
    var theme : String!
    var type : String!
    var unique : Bool!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        accept = json["accept"].stringValue
        alias = json["alias"]
        answers = [Answer]()
        let answersArray = json["answers"].arrayValue
        for answersJson in answersArray{
            let value = Answer(fromJson: answersJson)
            answers.append(value)
        }
        carry = json["carry"].stringValue
        carryforwardsource = json["carryforwardsource"].intValue
        checkdns = json["checkdns"].boolValue
        disabled = json["disabled"].boolValue
        fields = [JSON]()
        let fieldsArray = json["fields"].arrayValue
        for fieldsJson in fieldsArray{
            fields.append(fieldsJson)
        }
        formId = json["form_id"].intValue
        helpText = json["helpText"]
        id = json["id"].stringValue
        inline = json["inline"].boolValue
        inputType = json["inputType"].stringValue
        intro = json["intro"].stringValue
        label = json["label"].stringValue
        max = json["max"]
        maxSize = json["maxSize"]
        min = json["min"]
        minSize = json["minSize"]
        multiple = json["multiple"].boolValue
        number = json["number"].stringValue
        options = [Option]()
        let optionsArray = json["options"].arrayValue
        for optionsJson in optionsArray{
            let value = Option(fromJson: optionsJson)
            options.append(value)
        }
        pattern = json["pattern"]
        placeholder = json["placeholder"]
        predefinedValue = json["predefinedValue"]
        questions = [Question]()
        let questionsArray = json["questions"].arrayValue
        for questionsJson in questionsArray{
            let value = Question(fromJson: questionsJson)
            questions.append(value)
        }
        ranks = json["ranks"].intValue
        readOnly = json["readOnly"].boolValue
        required = json["required"].boolValue
        showLabel = json["showLabel"].boolValue
        shuffle = json["shuffle"].boolValue
        side1 = json["side1"].stringValue
        side2 = json["side2"].stringValue
        size = json["size"].stringValue
        text = json["text"].stringValue
        theme = json["theme"].stringValue
        type = json["type"].stringValue
        unique = json["unique"].boolValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if accept != nil{
        	dictionary["accept"] = accept
        }
        if alias != nil{
        	dictionary["alias"] = alias
        }
        if answers != nil{
        var dictionaryElements = [[String:Any]]()
        for answersElement in answers {
        	dictionaryElements.append(answersElement.toDictionary())
        }
        dictionary["answers"] = dictionaryElements
        }
        if carry != nil{
        	dictionary["carry"] = carry
        }
        if carryforwardsource != nil{
        	dictionary["carryforwardsource"] = carryforwardsource
        }
        if checkdns != nil{
        	dictionary["checkdns"] = checkdns
        }
        if disabled != nil{
        	dictionary["disabled"] = disabled
        }
        if fields != nil{
        	dictionary["fields"] = fields
        }
        if formId != nil{
        	dictionary["form_id"] = formId
        }
        if helpText != nil{
        	dictionary["helpText"] = helpText
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if inline != nil{
        	dictionary["inline"] = inline
        }
        if inputType != nil{
        	dictionary["inputType"] = inputType
        }
        if intro != nil{
        	dictionary["intro"] = intro
        }
        if label != nil{
        	dictionary["label"] = label
        }
        if max != nil{
        	dictionary["max"] = max
        }
        if maxSize != nil{
        	dictionary["maxSize"] = maxSize
        }
        if min != nil{
        	dictionary["min"] = min
        }
        if minSize != nil{
        	dictionary["minSize"] = minSize
        }
        if multiple != nil{
        	dictionary["multiple"] = multiple
        }
        if number != nil{
        	dictionary["number"] = number
        }
        if options != nil{
        var dictionaryElements = [[String:Any]]()
        for optionsElement in options {
        	dictionaryElements.append(optionsElement.toDictionary())
        }
        dictionary["options"] = dictionaryElements
        }
        if pattern != nil{
        	dictionary["pattern"] = pattern
        }
        if placeholder != nil{
        	dictionary["placeholder"] = placeholder
        }
        if predefinedValue != nil{
        	dictionary["predefinedValue"] = predefinedValue
        }
        if questions != nil{
        var dictionaryElements = [[String:Any]]()
        for questionsElement in questions {
        	dictionaryElements.append(questionsElement.toDictionary())
        }
        dictionary["questions"] = dictionaryElements
        }
        if ranks != nil{
        	dictionary["ranks"] = ranks
        }
        if readOnly != nil{
        	dictionary["readOnly"] = readOnly
        }
        if required != nil{
        	dictionary["required"] = required
        }
        if showLabel != nil{
        	dictionary["showLabel"] = showLabel
        }
        if shuffle != nil{
        	dictionary["shuffle"] = shuffle
        }
        if side1 != nil{
        	dictionary["side1"] = side1
        }
        if side2 != nil{
        	dictionary["side2"] = side2
        }
        if size != nil{
        	dictionary["size"] = size
        }
        if text != nil{
        	dictionary["text"] = text
        }
        if theme != nil{
        	dictionary["theme"] = theme
        }
        if type != nil{
        	dictionary["type"] = type
        }
        if unique != nil{
        	dictionary["unique"] = unique
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		accept = aDecoder.decodeObject(forKey: "accept") as? String
		alias = aDecoder.decodeObject(forKey: "alias") as? JSON
		answers = aDecoder.decodeObject(forKey: "answers") as? [Answer]
		carry = aDecoder.decodeObject(forKey: "carry") as? String
		carryforwardsource = aDecoder.decodeObject(forKey: "carryforwardsource") as? Int
		checkdns = aDecoder.decodeObject(forKey: "checkdns") as? Bool
		disabled = aDecoder.decodeObject(forKey: "disabled") as? Bool
		fields = aDecoder.decodeObject(forKey: "fields") as? [JSON]
		formId = aDecoder.decodeObject(forKey: "form_id") as? Int
		helpText = aDecoder.decodeObject(forKey: "helpText") as? JSON
		id = aDecoder.decodeObject(forKey: "id") as? String
		inline = aDecoder.decodeObject(forKey: "inline") as? Bool
		inputType = aDecoder.decodeObject(forKey: "inputType") as? String
		intro = aDecoder.decodeObject(forKey: "intro") as? String
		label = aDecoder.decodeObject(forKey: "label") as? String
		max = aDecoder.decodeObject(forKey: "max") as? JSON
		maxSize = aDecoder.decodeObject(forKey: "maxSize") as? JSON
		min = aDecoder.decodeObject(forKey: "min") as? JSON
		minSize = aDecoder.decodeObject(forKey: "minSize") as? JSON
		multiple = aDecoder.decodeObject(forKey: "multiple") as? Bool
		number = aDecoder.decodeObject(forKey: "number") as? String
		options = aDecoder.decodeObject(forKey: "options") as? [Option]
		pattern = aDecoder.decodeObject(forKey: "pattern") as? JSON
		placeholder = aDecoder.decodeObject(forKey: "placeholder") as? JSON
		predefinedValue = aDecoder.decodeObject(forKey: "predefinedValue") as? JSON
		questions = aDecoder.decodeObject(forKey: "questions") as? [Question]
		ranks = aDecoder.decodeObject(forKey: "ranks") as? Int
		readOnly = aDecoder.decodeObject(forKey: "readOnly") as? Bool
		required = aDecoder.decodeObject(forKey: "required") as? Bool
		showLabel = aDecoder.decodeObject(forKey: "showLabel") as? Bool
		shuffle = aDecoder.decodeObject(forKey: "shuffle") as? Bool
		side1 = aDecoder.decodeObject(forKey: "side1") as? String
		side2 = aDecoder.decodeObject(forKey: "side2") as? String
		size = aDecoder.decodeObject(forKey: "size") as? String
		text = aDecoder.decodeObject(forKey: "text") as? String
		theme = aDecoder.decodeObject(forKey: "theme") as? String
		type = aDecoder.decodeObject(forKey: "type") as? String
		unique = aDecoder.decodeObject(forKey: "unique") as? Bool
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if accept != nil{
			aCoder.encode(accept, forKey: "accept")
		}
		if alias != nil{
			aCoder.encode(alias, forKey: "alias")
		}
		if answers != nil{
			aCoder.encode(answers, forKey: "answers")
		}
		if carry != nil{
			aCoder.encode(carry, forKey: "carry")
		}
		if carryforwardsource != nil{
			aCoder.encode(carryforwardsource, forKey: "carryforwardsource")
		}
		if checkdns != nil{
			aCoder.encode(checkdns, forKey: "checkdns")
		}
		if disabled != nil{
			aCoder.encode(disabled, forKey: "disabled")
		}
		if fields != nil{
			aCoder.encode(fields, forKey: "fields")
		}
		if formId != nil{
			aCoder.encode(formId, forKey: "form_id")
		}
		if helpText != nil{
			aCoder.encode(helpText, forKey: "helpText")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if inline != nil{
			aCoder.encode(inline, forKey: "inline")
		}
		if inputType != nil{
			aCoder.encode(inputType, forKey: "inputType")
		}
		if intro != nil{
			aCoder.encode(intro, forKey: "intro")
		}
		if label != nil{
			aCoder.encode(label, forKey: "label")
		}
		if max != nil{
			aCoder.encode(max, forKey: "max")
		}
		if maxSize != nil{
			aCoder.encode(maxSize, forKey: "maxSize")
		}
		if min != nil{
			aCoder.encode(min, forKey: "min")
		}
		if minSize != nil{
			aCoder.encode(minSize, forKey: "minSize")
		}
		if multiple != nil{
			aCoder.encode(multiple, forKey: "multiple")
		}
		if number != nil{
			aCoder.encode(number, forKey: "number")
		}
		if options != nil{
			aCoder.encode(options, forKey: "options")
		}
		if pattern != nil{
			aCoder.encode(pattern, forKey: "pattern")
		}
		if placeholder != nil{
			aCoder.encode(placeholder, forKey: "placeholder")
		}
		if predefinedValue != nil{
			aCoder.encode(predefinedValue, forKey: "predefinedValue")
		}
		if questions != nil{
			aCoder.encode(questions, forKey: "questions")
		}
		if ranks != nil{
			aCoder.encode(ranks, forKey: "ranks")
		}
		if readOnly != nil{
			aCoder.encode(readOnly, forKey: "readOnly")
		}
		if required != nil{
			aCoder.encode(required, forKey: "required")
		}
		if showLabel != nil{
			aCoder.encode(showLabel, forKey: "showLabel")
		}
		if shuffle != nil{
			aCoder.encode(shuffle, forKey: "shuffle")
		}
		if side1 != nil{
			aCoder.encode(side1, forKey: "side1")
		}
		if side2 != nil{
			aCoder.encode(side2, forKey: "side2")
		}
		if size != nil{
			aCoder.encode(size, forKey: "size")
		}
		if text != nil{
			aCoder.encode(text, forKey: "text")
		}
		if theme != nil{
			aCoder.encode(theme, forKey: "theme")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if unique != nil{
			aCoder.encode(unique, forKey: "unique")
		}

	}

}
