//
//  FirebaseModels.swift
//  HB141
//
//  Created by Daniel Becker on 2/22/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class User : FIRDataObject {
    public var address : String = ""
    public var emailAddress : String = ""
    public var userType : String = ""
    
    override func toDictionary() -> Dictionary<String, Any> {
        return self.dictionaryWithValues(forKeys: ["address", "emailAddress", "userType"])
    }
}

class Report : FIRDataObject {

    public var dateTime : String = ""
    public var location: String = ""
    public var reportNumber: String = ""
    public var userId: String = ""

    
    override func toDictionary() -> Dictionary<String, Any> {
        return self.dictionaryWithValues(forKeys: ["dateTime", "location", "reportNumber", "userId"])
    }
}

class PurityReport : Report {
    public var condition : String = ""
    public var containmentPPM : String = ""
    public var virusPPM: String = ""
    
    override func toDictionary() -> Dictionary<String, Any> {
        return self.dictionaryWithValues(forKeys: ["condition", "containmentPPM", "dateTime", "location", "reportNumber", "userId", "virusPPM"])
    }
}

class SourceReport : Report {
    public var type : String = ""
    public var condition : String = ""
    
    override func toDictionary() -> Dictionary<String, Any> {
        return self.dictionaryWithValues(forKeys: ["dateTime", "location", "reportNumber", "userId", "type", "condition"])
    }
}


class FIRDataObject: NSObject {
    
    required init(snapshot: FIRDataSnapshot) {
        
        super.init()
        
        for child in snapshot.children.allObjects as? [FIRDataSnapshot] ?? [] {
            let key = String(child.key.characters.filter { !" \n\t\r".characters.contains($0) })
            if responds(to: Selector(key)) {
                if child.value is Bool {
                    let boolValue = child.value as! Bool
                    let boolString = boolValue.description
                    setValue(boolString, forKey: key)
                } else {
                    setValue(child.value, forKey: key)
                }
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        return Dictionary<String, Any>()
    }
}

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
