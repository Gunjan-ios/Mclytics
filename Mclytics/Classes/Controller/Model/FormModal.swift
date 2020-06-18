//
//  FormModal.swift
//  Mclytics
//
//  Created by Riddhi Shah on 04/06/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import Foundation

class MainFormModal : NSObject, NSCoding {
    
    var fields = [FieldsModal]()
    var autonumbering : Int = 0
    var resume : Int = 0
    var index : Int = 0
    var updated_at : Int = 0
    var urls : String = "" //Don't know data type
    var formSteps : Bool = false
    var recaptcha : Int = 0
    var authorized_urls : Int = 0
    var rules = NSArray() //Don't know data type
    var novalidate : Int = 0
    var status : Int = 0
    var name : String = ""
    var autocomplete : Int = 0
    var save : Int = 0
    var slug : String = ""
    var language : String = ""
    var dashboard : String = ""//Don't know data type
    var honeypot : Int = 0
    var message : String = ""
    var shuffle : Bool = false
    var timer : Int = 0
    var use_password : Int = 0
    var analytics : Int = 0
    var id : Int = 0//Don't know data type
    var created_at : Double = 0.0
    var password : String = ""
    
    override init() {
//        super.init()
    }

    convenience init(_ dict : NSDictionary) {
        self.init()
        
        self.fields = []
        let fieldsArray = dict.object_forKeyWithValidationForClass_NSArray(aKey: "fields")
        for i in 0..<fieldsArray.count {
            let dictData = fieldsArray.object(at: i) as! NSDictionary
            let modelData = FieldsModal(dictData)
            self.fields.append(modelData)
        }
        
        self.autonumbering = dict.object_forKeyWithValidationForClass_Int(aKey: "autonumbering")
        self.resume = dict.object_forKeyWithValidationForClass_Int(aKey: "resume")
        self.index = dict.object_forKeyWithValidationForClass_Int(aKey: "index")
        self.updated_at = dict.object_forKeyWithValidationForClass_Int(aKey: "updated_at")
        self.urls = dict.object_forKeyWithValidationForClass_String(aKey: "urls")
        self.formSteps = dict.object_forKeyWithValidationForClass_Bool(aKey: "formSteps")
        self.recaptcha = dict.object_forKeyWithValidationForClass_Int(aKey: "recaptcha")
        self.authorized_urls = dict.object_forKeyWithValidationForClass_Int(aKey: "authorized_urls")
        self.rules = dict.object_forKeyWithValidationForClass_NSArray(aKey: "rules")
        self.novalidate = dict.object_forKeyWithValidationForClass_Int(aKey: "novalidate")
        self.status = dict.object_forKeyWithValidationForClass_Int(aKey: "status")
        self.name = dict.object_forKeyWithValidationForClass_String(aKey: "name")
        self.autocomplete = dict.object_forKeyWithValidationForClass_Int(aKey: "autocomplete")
        self.save = dict.object_forKeyWithValidationForClass_Int(aKey: "save")
        self.slug = dict.object_forKeyWithValidationForClass_String(aKey: "slug")
        self.language = dict.object_forKeyWithValidationForClass_String(aKey: "language")
        self.dashboard = dict.object_forKeyWithValidationForClass_String(aKey: "dashboard")
        self.honeypot = dict.object_forKeyWithValidationForClass_Int(aKey: "honeypot")
        self.message = dict.object_forKeyWithValidationForClass_String(aKey: "message")
        self.shuffle = dict.object_forKeyWithValidationForClass_Bool(aKey: "shuffle")
        self.timer = dict.object_forKeyWithValidationForClass_Int(aKey: "timer")
        self.use_password = dict.object_forKeyWithValidationForClass_Int(aKey: "use_password")
        self.analytics = dict.object_forKeyWithValidationForClass_Int(aKey: "analytics")
        self.id = dict.object_forKeyWithValidationForClass_Int(aKey: "id")
        self.created_at = dict.object_forKeyWithValidationForClass_Double(aKey: "created_at")
        self.password = dict.object_forKeyWithValidationForClass_String(aKey: "password")
    }

    required init(coder aDecoder: NSCoder) {
        
        let obj = aDecoder.decodeObject(forKey: "fields") as! Data
        self.fields = NSKeyedUnarchiver.unarchiveObject(with: obj) as! [FieldsModal]
        
        self.autonumbering = aDecoder.decodeInteger(forKey: "autonumbering")
        self.resume = aDecoder.decodeInteger(forKey: "resume")
        self.index = aDecoder.decodeInteger(forKey: "index")
        self.updated_at = aDecoder.decodeInteger(forKey: "updated_at")
        self.urls = aDecoder.decodeObject(forKey: "urls") as! String
        self.formSteps = aDecoder.decodeBool(forKey: "formSteps")
        self.recaptcha = aDecoder.decodeInteger(forKey: "recaptcha")
        self.authorized_urls = aDecoder.decodeInteger(forKey: "authorized_urls")
        self.rules = aDecoder.decodeObject(forKey: "rules") as! NSArray
        self.novalidate = aDecoder.decodeInteger(forKey: "novalidate")
        self.status = aDecoder.decodeInteger(forKey: "status")
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.autocomplete = aDecoder.decodeInteger(forKey: "autocomplete")
        self.save = aDecoder.decodeInteger(forKey: "save")
        self.slug = aDecoder.decodeObject(forKey: "slug") as! String
        self.language = aDecoder.decodeObject(forKey: "language") as! String
        self.dashboard = aDecoder.decodeObject(forKey: "dashboard") as! String
        self.honeypot = aDecoder.decodeInteger(forKey: "honeypot")
        self.message = aDecoder.decodeObject(forKey: "message") as! String
        self.shuffle = aDecoder.decodeBool(forKey: "shuffle")
        self.timer = aDecoder.decodeInteger(forKey: "timer")
        self.use_password = aDecoder.decodeInteger(forKey: "use_password")
        self.analytics = aDecoder.decodeInteger(forKey: "analytics")
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.created_at = aDecoder.decodeDouble(forKey: "created_at")
        self.password = aDecoder.decodeObject(forKey: "password") as! String
    }

    func encode(with aCoder: NSCoder) {
        
        let fieldsData = NSKeyedArchiver.archivedData(withRootObject: fields)
        aCoder.encode(fieldsData, forKey: "fields")
        
        aCoder.encode(autonumbering, forKey: "autonumbering")
        aCoder.encode(resume, forKey: "resume")
        aCoder.encode(index, forKey: "index")
        aCoder.encode(updated_at, forKey: "updated_at")
        aCoder.encode(urls, forKey: "urls")
        aCoder.encode(formSteps, forKey: "formSteps")
        aCoder.encode(recaptcha, forKey: "recaptcha")
        aCoder.encode(authorized_urls, forKey: "authorized_urls")
        aCoder.encode(rules, forKey: "rules")
        aCoder.encode(novalidate, forKey: "novalidate")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(autocomplete, forKey: "autocomplete")
        aCoder.encode(save, forKey: "save")
        aCoder.encode(slug, forKey: "slug")
        aCoder.encode(language, forKey: "language")
        aCoder.encode(dashboard, forKey: "dashboard")
        aCoder.encode(honeypot, forKey: "honeypot")
        aCoder.encode(message, forKey: "message")
        aCoder.encode(shuffle, forKey: "shuffle")
        aCoder.encode(timer, forKey: "timer")
        aCoder.encode(use_password, forKey: "use_password")
        aCoder.encode(analytics, forKey: "analytics")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(created_at, forKey: "created_at")
        aCoder.encode(password, forKey: "password")
    }
}

class FieldsModal : NSObject, NSCoding {
    
    var text : String = ""
    var id : String = ""
    var form_id : Int = 0
    var type : String = ""
    
    var carry : String = ""
    var readOnly : Bool = false
    var pattern : String = ""
    var helpText : String = ""
    var required : Bool = false
    var unique : Bool = false
    var alias : String = "" //Don't know Data type
    var placeholder : String = ""
    var inputType : String = ""
    var label : String = ""
    var disabled : Bool = false
    var predefinedValue : String = ""
    var checkdns : Bool = false
    var multiple : Bool = false
    var min : Int = 0
    var max : Int = 0
    
    var inline : Bool = false
    var options = [OptionsModal]()
    var selectedOptions = [OptionsModal]()
    var side2 : String = ""
    var side1 : String = ""

    var showLabel : Bool = false
    var maxSize : Int = 0 //Don't know Data type
    var minSize : Int = 0 //Don't know Data type
    var accept : String = ""
    var ranks : Int = 0
    var questions = [OptionsModal]()
    var answers = [OptionsModal]()
    var carryforwardsource : String = ""
    var intro : String = ""
    var answer : String = ""
    var checkbox_answer : [String] = [String]()
    var lat : Double = 0.0
    var long : Double = 0.0
    

    
    override init() {
//        super.init()
    }

    convenience init(_ dict : NSDictionary) {
        self.init()
        self.lat = dict.object_forKeyWithValidationForClass_Double(aKey: "lat")
        self.long = dict.object_forKeyWithValidationForClass_Double(aKey: "long")
        
        self.text = dict.object_forKeyWithValidationForClass_String(aKey: "text")
        self.id = dict.object_forKeyWithValidationForClass_String(aKey: "id")
        self.form_id = dict.object_forKeyWithValidationForClass_Int(aKey: "form_id")
        self.type = dict.object_forKeyWithValidationForClass_String(aKey: "type")
        self.carry = dict.object_forKeyWithValidationForClass_String(aKey: "carry")
        self.readOnly = dict.object_forKeyWithValidationForClass_Bool(aKey: "readOnly")
        self.pattern = dict.object_forKeyWithValidationForClass_String(aKey: "pattern")
        self.helpText = dict.object_forKeyWithValidationForClass_String(aKey: "helpText")
        self.required = dict.object_forKeyWithValidationForClass_Bool(aKey: "required")
        self.unique = dict.object_forKeyWithValidationForClass_Bool(aKey: "unique")
        self.alias = dict.object_forKeyWithValidationForClass_String(aKey: "alias")
        self.placeholder = dict.object_forKeyWithValidationForClass_String(aKey: "placeholder")
        self.inputType = dict.object_forKeyWithValidationForClass_String(aKey: "inputType")
        self.label = dict.object_forKeyWithValidationForClass_String(aKey: "label")
        self.disabled = dict.object_forKeyWithValidationForClass_Bool(aKey: "disabled")
        self.predefinedValue = dict.object_forKeyWithValidationForClass_String(aKey: "predefinedValue")
        self.checkdns = dict.object_forKeyWithValidationForClass_Bool(aKey: "checkdns")
        self.multiple = dict.object_forKeyWithValidationForClass_Bool(aKey: "multiple")
        self.min = dict.object_forKeyWithValidationForClass_Int(aKey: "min")
        self.max = dict.object_forKeyWithValidationForClass_Int(aKey: "max")
        self.inline = dict.object_forKeyWithValidationForClass_Bool(aKey: "inline")
        
        self.options = []
        let optionsArray = dict.object_forKeyWithValidationForClass_NSArray(aKey: "options")
        for i in 0..<optionsArray.count {
            let dictData = optionsArray.object(at: i) as! NSDictionary
            let modelData = OptionsModal(dictData)
            self.options.append(modelData)
        }
        
        self.selectedOptions = []
        let selectOptionsArray = dict.object_forKeyWithValidationForClass_NSArray(aKey: "selectedOptions")
        for i in 0..<selectOptionsArray.count {
            let dictData = selectOptionsArray.object(at: i) as! NSDictionary
            let modelData = OptionsModal(dictData)
            self.selectedOptions.append(modelData)
        }
        
         self.checkbox_answer  = dict.object_forKeyWithValidationForClass_stringArray(aKey: "checkbox_answer")

        
        self.side1 = dict.object_forKeyWithValidationForClass_String(aKey: "side1")
        self.side2 = dict.object_forKeyWithValidationForClass_String(aKey: "side2")
        self.showLabel = dict.object_forKeyWithValidationForClass_Bool(aKey: "showLabel")
        self.maxSize = dict.object_forKeyWithValidationForClass_Int(aKey: "maxSize")
        self.minSize = dict.object_forKeyWithValidationForClass_Int(aKey: "minSize")
        self.accept = dict.object_forKeyWithValidationForClass_String(aKey: "accept")
        self.ranks = dict.object_forKeyWithValidationForClass_Int(aKey: "ranks")
        
        self.questions = []
        let questionsArray = dict.object_forKeyWithValidationForClass_NSArray(aKey: "questions")
        for i in 0..<questionsArray.count {
            let dictData = questionsArray.object(at: i) as! NSDictionary
            let modelData = OptionsModal(dictData)
            self.questions.append(modelData)
        }
        
        self.answers = []
        let answersArray = dict.object_forKeyWithValidationForClass_NSArray(aKey: "answers")
        for i in 0..<answersArray.count {
            let dictData = answersArray.object(at: i) as! NSDictionary
            let modelData = OptionsModal(dictData)
            self.answers.append(modelData)
        }
        
        self.carryforwardsource = dict.object_forKeyWithValidationForClass_String(aKey: "carryforwardsource")
        self.intro = dict.object_forKeyWithValidationForClass_String(aKey: "intro")
    
        
    }

    required init(coder aDecoder: NSCoder) {
        
        self.text = aDecoder.decodeObject(forKey: "text") as! String
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.form_id = aDecoder.decodeInteger(forKey: "form_id")
        self.type = aDecoder.decodeObject(forKey: "type") as! String
        self.carry = aDecoder.decodeObject(forKey: "carry") as! String
        self.readOnly = aDecoder.decodeBool(forKey: "readOnly")
        self.pattern = aDecoder.decodeObject(forKey: "pattern") as! String
        self.helpText = aDecoder.decodeObject(forKey: "helpText") as! String
        self.required = aDecoder.decodeBool(forKey: "required")
        self.unique = aDecoder.decodeBool(forKey: "unique")
        self.alias = aDecoder.decodeObject(forKey: "alias") as! String
        self.placeholder = aDecoder.decodeObject(forKey: "placeholder") as! String
        self.inputType = aDecoder.decodeObject(forKey: "inputType") as! String
        self.label = aDecoder.decodeObject(forKey: "label") as! String
        self.disabled = aDecoder.decodeBool(forKey: "disabled")
        self.predefinedValue = aDecoder.decodeObject(forKey: "predefinedValue") as! String
        self.checkdns = aDecoder.decodeBool(forKey: "checkdns")
        self.multiple = aDecoder.decodeBool(forKey: "multiple")
        self.min = aDecoder.decodeInteger(forKey: "min")
        self.max = aDecoder.decodeInteger(forKey: "max")
        
        let obj = aDecoder.decodeObject(forKey: "options") as! Data
        self.options = NSKeyedUnarchiver.unarchiveObject(with: obj) as! [OptionsModal]
        
        let selectobj = aDecoder.decodeObject(forKey: "selectedOptions") as! Data
        self.selectedOptions = NSKeyedUnarchiver.unarchiveObject(with: selectobj) as! [OptionsModal]
        
        let selectobj1 = aDecoder.decodeObject(forKey: "checkbox_answer") as! Data
        self.checkbox_answer = NSKeyedUnarchiver.unarchiveObject(with: selectobj1) as! [String]
        
        
        self.side1 = aDecoder.decodeObject(forKey: "side1") as! String
        self.side2 = aDecoder.decodeObject(forKey: "side2") as! String
        self.showLabel = aDecoder.decodeBool(forKey: "showLabel")
        self.maxSize = aDecoder.decodeInteger(forKey: "maxSize")
        self.minSize = aDecoder.decodeInteger(forKey: "minSize")
        self.accept = aDecoder.decodeObject(forKey: "accept") as! String
        self.ranks = aDecoder.decodeInteger(forKey: "ranks")
        
        let objQuestion = aDecoder.decodeObject(forKey: "questions") as! Data
        self.questions = NSKeyedUnarchiver.unarchiveObject(with: objQuestion) as! [OptionsModal]
        
        let objAnswer = aDecoder.decodeObject(forKey: "answers") as! Data
        self.answers = NSKeyedUnarchiver.unarchiveObject(with: objAnswer) as! [OptionsModal]
        
        self.carryforwardsource = aDecoder.decodeObject(forKey: "carryforwardsource") as! String
        self.intro = aDecoder.decodeObject(forKey: "intro") as! String
        self.answer = aDecoder.decodeObject(forKey: "answer") as! String
        
        self.lat = aDecoder.decodeDouble(forKey: "lat")
        self.long = aDecoder.decodeDouble(forKey: "long")
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "text")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(form_id, forKey: "form_id")
        aCoder.encode(type, forKey: "type")
        
        aCoder.encode(carry, forKey: "carry")
        aCoder.encode(readOnly, forKey: "readOnly")
        aCoder.encode(pattern, forKey: "pattern")
        aCoder.encode(helpText, forKey: "helpText")
        aCoder.encode(required, forKey: "required")
        aCoder.encode(unique, forKey: "unique")
        aCoder.encode(alias, forKey: "alias")
        aCoder.encode(placeholder, forKey: "placeholder")
        aCoder.encode(inputType, forKey: "inputType")
        aCoder.encode(label, forKey: "label")
        aCoder.encode(disabled, forKey: "disabled")
        aCoder.encode(predefinedValue, forKey: "predefinedValue")
        aCoder.encode(checkdns, forKey: "checkdns")
        aCoder.encode(multiple, forKey: "multiple")
        aCoder.encode(min, forKey: "min")
        aCoder.encode(max, forKey: "max")
        
        let fieldsData = NSKeyedArchiver.archivedData(withRootObject: options)
        aCoder.encode(fieldsData, forKey: "options")
        
        let selectFieldsData = NSKeyedArchiver.archivedData(withRootObject: selectedOptions)
        aCoder.encode(selectFieldsData, forKey: "selectedOptions")
        
        let checkBoxData = NSKeyedArchiver.archivedData(withRootObject: checkbox_answer)
        aCoder.encode(checkBoxData, forKey: "checkbox_answer")

        
        aCoder.encode(side1, forKey: "side1")
        aCoder.encode(side2, forKey: "side2")
        aCoder.encode(showLabel, forKey: "showLabel")
        aCoder.encode(maxSize, forKey: "maxSize")
        aCoder.encode(minSize, forKey: "minSize")
        aCoder.encode(accept, forKey: "accept")
        aCoder.encode(ranks, forKey: "ranks")
        
        let questionData = NSKeyedArchiver.archivedData(withRootObject: questions)
        aCoder.encode(questionData, forKey: "questions")
        
        let answerData = NSKeyedArchiver.archivedData(withRootObject: answers)
        aCoder.encode(answerData, forKey: "answers")
        
        aCoder.encode(carryforwardsource, forKey: "carryforwardsource")
        aCoder.encode(intro, forKey: "intro")
        
        aCoder.encode(answer, forKey: "answer")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(long, forKey: "long")

    }
}

class OptionsModal : NSObject, NSCoding {
    
    var selected : Bool = false
    var label : String = ""
    var checked : Bool = false
    var answer  = ""
    var ans_key  = ""
    var ans_value  = ""
    var index  = 0

    override init() {
//        super.init()
    }

    convenience init(_ dict : NSDictionary) {
        self.init()
        
        self.selected = dict.object_forKeyWithValidationForClass_Bool(aKey: "selected")
        self.label = dict.object_forKeyWithValidationForClass_String(aKey: "label")
        self.index = dict.object_forKeyWithValidationForClass_Int(aKey: "index")
        self.checked = dict.object_forKeyWithValidationForClass_Bool(aKey: "checked")
        self.answer = dict.object_forKeyWithValidationForClass_String(aKey: "answer")
        
    }

    required init(coder aDecoder: NSCoder) {
        self.selected = aDecoder.decodeBool(forKey: "selected")
        self.label = aDecoder.decodeObject(forKey: "label") as! String
        self.index = aDecoder.decodeInteger(forKey: "index")
        self.checked = aDecoder.decodeBool(forKey: "checked")
        self.answer = aDecoder.decodeObject(forKey: "answer") as! String
        
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(selected, forKey: "selected")
        aCoder.encode(label, forKey: "label")
        aCoder.encode(index, forKey: "index")
        aCoder.encode(checked, forKey: "checked")
        aCoder.encode(answer, forKey: "answer")
        
    }
}

//[
//  {
//    "fields" : [
//      {
//        "text" : "Test",
//        "id" : "heading_345643",
//        "form_id" : 272,
//        "type" : "heading"
//      },
//      {
//        "text" : "<p><span style=\"background-color: rgb(255, 255, 255); color: rgb(192, 80, 77);\">hello&nbsp;<\/span><\/p><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(192, 80, 77);\">this is text<\/span><\/p><p><br><\/p><p><br><\/p><p><br><\/p>",
//        "id" : "paragraph_197170",
//        "form_id" : 272,
//        "type" : "paragraph"
//      },
//      {
//        "carry" : "$[text_921729]",
//        "readOnly" : false,
//        "pattern" : null,
//        "helpText" : null,
//        "required" : true,
//        "form_id" : 272,
//        "unique" : false,
//        "alias" : null,
//        "placeholder" : "enter your name",
//        "type" : "text",
//        "inputType" : "text",
//        "id" : "text_921729",
//        "label" : "name",
//        "disabled" : false,
//        "predefinedValue" : null
//      },
//      {
//        "readOnly" : false,
//        "pattern" : null,
//        "helpText" : null,
//        "checkdns" : false,
//        "required" : false,
//        "alias" : null,
//        "unique" : false,
//        "placeholder" : null,
//        "type" : "email",
//        "form_id" : 272,
//        "multiple" : false,
//        "id" : "email_940270",
//        "label" : "Email Field",
//        "disabled" : false,
//        "predefinedValue" : null
//      },
//      {
//        "readOnly" : false,
//        "helpText" : null,
//        "pattern" : null,
//        "checkdns" : false,
//        "required" : false,
//        "type" : "phone",
//        "unique" : false,
//        "placeholder" : null,
//        "form_id" : 272,
//        "alias" : null,
//        "min" : null,
//        "multiple" : false,
//        "max" : 11,
//        "id" : "phone_976367",
//        "label" : "Phone Field",
//        "disabled" : false,
//        "predefinedValue" : null
//      },
//      {
//        "type" : "textarea",
//        "required" : false,
//        "id" : "textarea_292045",
//        "disabled" : false,
//        "form_id" : 272,
//        "readOnly" : false,
//        "alias" : null,
//        "placeholder" : null,
//        "helpText" : null,
//        "label" : "Text Area",
//        "predefinedValue" : null,
//        "unique" : false
//      },
//      {
//        "inline" : false,
//        "required" : false,
//        "id" : "checkbox_113086",
//        "disabled" : false,
//        "form_id" : 272,
//        "options" : [
//          {
//            "selected" : false,
//            "label" : "First Choice",
//            "checked" : true
//          },
//          {
//            "selected" : false,
//            "label" : "Second Choice",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "Third Choice",
//            "checked" : false
//          }
//        ],
//        "alias" : null,
//        "readOnly" : false,
//        "shuffle" : false,
//        "helpText" : null,
//        "label" : "Check All That Apply",
//        "type" : "checkbox"
//      },
//      {
//        "inline" : false,
//        "required" : false,
//        "id" : "radio_652471",
//        "disabled" : false,
//        "form_id" : 272,
//        "options" : [
//          {
//            "selected" : true,
//            "label" : "First Choice",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "Second Choice",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "Third Choice",
//            "checked" : false
//          }
//        ],
//        "alias" : null,
//        "readOnly" : false,
//        "shuffle" : false,
//        "helpText" : null,
//        "label" : "Select a Choice",
//        "type" : "radio"
//      },
//      {
//        "side2" : "high",
//        "required" : false,
//        "ranks" : 10,
//        "id" : "sidebyside_722563",
//        "form_id" : 272,
//        "alias" : null,
//        "side1" : "low ",
//        "helpText" : null,
//        "label" : "Side by side",
//        "type" : "sidebyside"
//      },
//      {
//        "required" : true,
//        "id" : "rating_126680",
//        "form_id" : 272,
//        "options" : [
//          {
//            "selected" : false,
//            "label" : "Low quality",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "Medium quality",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "High quality",
//            "checked" : false
//          }
//        ],
//        "showLabel" : true,
//        "helpText" : null,
//        "label" : "Select1",
//        "inputType" : "star",
//        "type" : "rating"
//      },
//      {
//        "required" : false,
//        "id" : "rating_948411",
//        "form_id" : 272,
//        "options" : [
//          {
//            "selected" : false,
//            "label" : "Low quality",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "Medium quality",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "High quality",
//            "checked" : false
//          }
//        ],
//        "showLabel" : true,
//        "helpText" : null,
//        "label" : "Select a Choice33",
//        "inputType" : "slide",
//        "type" : "rating"
//      },
//      {
//        "required" : false,
//        "predefinedValue" : null,
//        "disabled" : false,
//        "form_id" : 272,
//        "id" : "date_819374",
//        "min" : null,
//        "placeholder" : null,
//        "helpText" : null,
//        "inputType" : "date",
//        "max" : null,
//        "label" : "Date Field",
//        "type" : "date"
//      },
//      {
//        "required" : false,
//        "multiple" : false,
//        "disabled" : false,
//        "form_id" : 272,
//        "options" : [
//          {
//            "selected" : true,
//            "label" : "First Choice",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "Second Choice",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "Third Choice",
//            "checked" : false
//          }
//        ],
//        "alias" : null,
//        "id" : "selectlist_271404",
//        "helpText" : null,
//        "label" : "Select a Choice",
//        "readOnly" : false,
//        "type" : "selectlist"
//      },
//      {
//        "required" : false,
//        "id" : "image_199753",
//        "disabled" : false,
//        "maxSize" : null,
//        "alias" : null,
//        "form_id" : 272,
//        "readOnly" : false,
//        "helpText" : null,
//        "label" : "Attach a image",
//        "minSize" : null,
//        "type" : "image"
//      },
//      {
//        "required" : false,
//        "id" : "video_331073",
//        "disabled" : false,
//        "maxSize" : null,
//        "alias" : null,
//        "form_id" : 272,
//        "readOnly" : false,
//        "helpText" : null,
//        "label" : "Attach a video",
//        "minSize" : null,
//        "type" : "video"
//      },
//      {
//        "required" : false,
//        "id" : "file_228311",
//        "disabled" : false,
//        "form_id" : 272,
//        "maxSize" : null,
//        "readOnly" : false,
//        "alias" : null,
//        "helpText" : null,
//        "label" : "Attach a File",
//        "minSize" : null,
//        "accept" : ".gif, .jpg, .png",
//        "type" : "file"
//      },
//      {
//        "required" : false,
//        "id" : "signature_827344",
//        "form_id" : 272,
//        "alias" : null,
//        "helpText" : null,
//        "label" : "Signature Pad",
//        "type" : "signature"
//      },
//      {
//        "ranks" : 5,
//        "required" : false,
//        "id" : "rankingscale_467909",
//        "form_id" : 272,
//        "options" : [
//          {
//            "selected" : false,
//            "label" : "First element",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "Second element",
//            "checked" : false
//          },
//          {
//            "selected" : false,
//            "label" : "Third element",
//            "checked" : false
//          }
//        ],
//        "alias" : null,
//        "helpText" : null,
//        "label" : "Ranking scale",
//        "type" : "rankingscale"
//      },
//      {
//        "required" : false,
//        "id" : "video_cap_925922",
//        "disabled" : false,
//        "maxSize" : null,
//        "alias" : null,
//        "form_id" : 272,
//        "readOnly" : false,
//        "helpText" : null,
//        "label" : "Capture video",
//        "minSize" : null,
//        "type" : "video_cap"
//      },
//      {
//        "id" : "matrix_37123",
//        "form_id" : 272,
//        "questions" : [
//          {
//            "label" : "Question 1"
//          },
//          {
//            "label" : "Question 2"
//          },
//          {
//            "label" : "Question 3"
//          }
//        ],
//        "answers" : [
//          {
//            "label" : "Answer 1"
//          },
//          {
//            "label" : "Answer 2"
//          },
//          {
//            "label" : "Answer 3"
//          }
//        ],
//        "inputType" : "radio",
//        "label" : "Matrix",
//        "type" : "matrix"
//      },
//      {
//        "required" : false,
//        "id" : "carryforward_139295",
//        "form_id" : 272,
//        "carryforwardsource" : 0,
//        "alias" : null,
//        "helpText" : null,
//        "label" : "Choice Carry Forward",
//        "inputType" : "radio",
//        "type" : "carryforward"
//      },
//      {
//        "label" : "Attach a geo",
//        "id" : "geolocation_702775",
//        "form_id" : 272,
//        "type" : "geolocation"
//      },
//      {
//        "minSize" : null,
//        "required" : false,
//        "form_id" : 272,
//        "maxSize" : null,
//        "id" : "audio_118999",
//        "helpText" : null,
//        "alias" : null,
//        "type" : "audio",
//        "label" : "Attach a voice record",
//        "readOnly" : false,
//        "disabled" : false
//      },
//      {
//        "form_id" : 272,
//        "theme" : "light",
//        "id" : "recaptcha_219070",
//        "size" : "normal",
//        "inputType" : "image",
//        "type" : "recaptcha"
//      },
//      {
//        "label" : "Choice Carry Forward",
//        "helpText" : null,
//        "inputType" : "radio",
//        "id" : "carryforward_59431",
//        "alias" : null,
//        "carryforwardsource" : 0,
//        "form_id" : 272,
//        "required" : false,
//        "type" : "carryforward"
//      },
//      {
//        "helpText" : null,
//        "id" : "signature_18376",
//        "alias" : null,
//        "type" : "signature",
//        "form_id" : 272,
//        "required" : false,
//        "label" : "Signature Pad1"
//      },
//      {
//        "helpText" : null,
//        "intro" : "Intro Text",
//        "id" : "rostergroup_131209",
//        "fields" : [
//
//        ],
//        "number" : "Number input name",
//        "alias" : null,
//        "type" : "rostergroup",
//        "form_id" : 272,
//        "label" : "Roster Group"
//      }
//    ],
//    "autonumbering" : 1,
//    "resume" : 0,
//    "index" : 154,
//    "updated_at" : 1590582681,
//    "urls" : null,
//    "formSteps" : false,
//    "recaptcha" : 1,
//    "authorized_urls" : 0,
//"rules" : [
//  {
//    "opposite" : 1,
//    "actions" : [
//      {
//        "value" : "toShow",
//        "fields" : [
//          {
//            "name" : "target",
//            "fields" : [
//              {
//                "name" : "targetField",
//                "value" : "image_410107"
//              }
//            ],
//            "value" : "field"
//          }
//        ],
//        "name" : "action-select"
//      }
//    ],
//    "status" : 1,
//    "ordinal" : 3,
//    "type" : "any",
//    "form_id" : 19,
//    "conditions" : [
//      {
//        "name" : "radio_0",
//        "value" : "Current Employee",
//        "operator" : "equalTo"
//      },
//      {
//        "name" : "sidebyside_489134",
//        "value" : "2",
//        "operator" : "equalTo"
//      }
//    ]
//  }
//],
//    "novalidate" : 0,
//    "status" : 1,
//    "name" : "Gunjan Test",
//    "autocomplete" : 1,
//    "save" : 1,
//    "slug" : "gunjan-test",
//    "language" : "en-US",
//    "dashboard" : null,
//    "honeypot" : 1,
//    "message" : null,
//    "shuffle" : false,
//    "timer" : 0,
//    "use_password" : 0,
//    "analytics" : 1,
//    "id" : 272,
//    "created_at" : 1590571956,
//    "password" : null
//  }
//]
