//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 2, 2020

import Foundation
import SwiftyJSON


class RootClass : NSObject, NSCoding{

    var analytics : Int!
    var authorizedUrls : Int!
    var autocomplete : Int!
    var autonumbering : Int!
    var createdAt : Int!
    var dashboard : JSON!
    var fields : [Field]!
    var formSteps : Bool!
    var honeypot : Int!
    var id : Int!
    var index : Int!
    var language : String!
    var message : JSON!
    var name : String!
    var novalidate : Int!
    var password : JSON!
    var recaptcha : Int!
    var resume : Int!
    var rules : [JSON]!
    var save : Int!
    var shuffle : Bool!
    var slug : String!
    var status : Int!
    var timer : Int!
    var updatedAt : Int!
    var urls : JSON!
    var usePassword : Int!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        analytics = json["analytics"].intValue
        authorizedUrls = json["authorized_urls"].intValue
        autocomplete = json["autocomplete"].intValue
        autonumbering = json["autonumbering"].intValue
        createdAt = json["created_at"].intValue
        dashboard = json["dashboard"]
        fields = [Field]()
        let fieldsArray = json["fields"].arrayValue
        for fieldsJson in fieldsArray{
            let value = Field(fromJson: fieldsJson)
            fields.append(value)
        }
        formSteps = json["formSteps"].boolValue
        honeypot = json["honeypot"].intValue
        id = json["id"].intValue
        index = json["index"].intValue
        language = json["language"].stringValue
        message = json["message"]
        name = json["name"].stringValue
        novalidate = json["novalidate"].intValue
        password = json["password"]
        recaptcha = json["recaptcha"].intValue
        resume = json["resume"].intValue
        rules = [JSON]()
        let rulesArray = json["rules"].arrayValue
        for rulesJson in rulesArray{
            rules.append(rulesJson)
        }
        save = json["save"].intValue
        shuffle = json["shuffle"].boolValue
        slug = json["slug"].stringValue
        status = json["status"].intValue
        timer = json["timer"].intValue
        updatedAt = json["updated_at"].intValue
        urls = json["urls"]
        usePassword = json["use_password"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if analytics != nil{
        	dictionary["analytics"] = analytics
        }
        if authorizedUrls != nil{
        	dictionary["authorized_urls"] = authorizedUrls
        }
        if autocomplete != nil{
        	dictionary["autocomplete"] = autocomplete
        }
        if autonumbering != nil{
        	dictionary["autonumbering"] = autonumbering
        }
        if createdAt != nil{
        	dictionary["created_at"] = createdAt
        }
        if dashboard != nil{
        	dictionary["dashboard"] = dashboard
        }
        if fields != nil{
        var dictionaryElements = [[String:Any]]()
        for fieldsElement in fields {
        	dictionaryElements.append(fieldsElement.toDictionary())
        }
        dictionary["fields"] = dictionaryElements
        }
        if formSteps != nil{
        	dictionary["formSteps"] = formSteps
        }
        if honeypot != nil{
        	dictionary["honeypot"] = honeypot
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if index != nil{
        	dictionary["index"] = index
        }
        if language != nil{
        	dictionary["language"] = language
        }
        if message != nil{
        	dictionary["message"] = message
        }
        if name != nil{
        	dictionary["name"] = name
        }
        if novalidate != nil{
        	dictionary["novalidate"] = novalidate
        }
        if password != nil{
        	dictionary["password"] = password
        }
        if recaptcha != nil{
        	dictionary["recaptcha"] = recaptcha
        }
        if resume != nil{
        	dictionary["resume"] = resume
        }
        if rules != nil{
        	dictionary["rules"] = rules
        }
        if save != nil{
        	dictionary["save"] = save
        }
        if shuffle != nil{
        	dictionary["shuffle"] = shuffle
        }
        if slug != nil{
        	dictionary["slug"] = slug
        }
        if status != nil{
        	dictionary["status"] = status
        }
        if timer != nil{
        	dictionary["timer"] = timer
        }
        if updatedAt != nil{
        	dictionary["updated_at"] = updatedAt
        }
        if urls != nil{
        	dictionary["urls"] = urls
        }
        if usePassword != nil{
        	dictionary["use_password"] = usePassword
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		analytics = aDecoder.decodeObject(forKey: "analytics") as? Int
		authorizedUrls = aDecoder.decodeObject(forKey: "authorized_urls") as? Int
		autocomplete = aDecoder.decodeObject(forKey: "autocomplete") as? Int
		autonumbering = aDecoder.decodeObject(forKey: "autonumbering") as? Int
		createdAt = aDecoder.decodeObject(forKey: "created_at") as? Int
		dashboard = aDecoder.decodeObject(forKey: "dashboard") as? JSON
		fields = aDecoder.decodeObject(forKey: "fields") as? [Field]
		formSteps = aDecoder.decodeObject(forKey: "formSteps") as? Bool
		honeypot = aDecoder.decodeObject(forKey: "honeypot") as? Int
		id = aDecoder.decodeObject(forKey: "id") as? Int
		index = aDecoder.decodeObject(forKey: "index") as? Int
		language = aDecoder.decodeObject(forKey: "language") as? String
		message = aDecoder.decodeObject(forKey: "message") as? JSON
		name = aDecoder.decodeObject(forKey: "name") as? String
		novalidate = aDecoder.decodeObject(forKey: "novalidate") as? Int
		password = aDecoder.decodeObject(forKey: "password") as? JSON
		recaptcha = aDecoder.decodeObject(forKey: "recaptcha") as? Int
		resume = aDecoder.decodeObject(forKey: "resume") as? Int
		rules = aDecoder.decodeObject(forKey: "rules") as? [JSON]
		save = aDecoder.decodeObject(forKey: "save") as? Int
		shuffle = aDecoder.decodeObject(forKey: "shuffle") as? Bool
		slug = aDecoder.decodeObject(forKey: "slug") as? String
		status = aDecoder.decodeObject(forKey: "status") as? Int
		timer = aDecoder.decodeObject(forKey: "timer") as? Int
		updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? Int
		urls = aDecoder.decodeObject(forKey: "urls") as? JSON
		usePassword = aDecoder.decodeObject(forKey: "use_password") as? Int
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if analytics != nil{
			aCoder.encode(analytics, forKey: "analytics")
		}
		if authorizedUrls != nil{
			aCoder.encode(authorizedUrls, forKey: "authorized_urls")
		}
		if autocomplete != nil{
			aCoder.encode(autocomplete, forKey: "autocomplete")
		}
		if autonumbering != nil{
			aCoder.encode(autonumbering, forKey: "autonumbering")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if dashboard != nil{
			aCoder.encode(dashboard, forKey: "dashboard")
		}
		if fields != nil{
			aCoder.encode(fields, forKey: "fields")
		}
		if formSteps != nil{
			aCoder.encode(formSteps, forKey: "formSteps")
		}
		if honeypot != nil{
			aCoder.encode(honeypot, forKey: "honeypot")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if index != nil{
			aCoder.encode(index, forKey: "index")
		}
		if language != nil{
			aCoder.encode(language, forKey: "language")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if novalidate != nil{
			aCoder.encode(novalidate, forKey: "novalidate")
		}
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}
		if recaptcha != nil{
			aCoder.encode(recaptcha, forKey: "recaptcha")
		}
		if resume != nil{
			aCoder.encode(resume, forKey: "resume")
		}
		if rules != nil{
			aCoder.encode(rules, forKey: "rules")
		}
		if save != nil{
			aCoder.encode(save, forKey: "save")
		}
		if shuffle != nil{
			aCoder.encode(shuffle, forKey: "shuffle")
		}
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if timer != nil{
			aCoder.encode(timer, forKey: "timer")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if urls != nil{
			aCoder.encode(urls, forKey: "urls")
		}
		if usePassword != nil{
			aCoder.encode(usePassword, forKey: "use_password")
		}

	}

}
