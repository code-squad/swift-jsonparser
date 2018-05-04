//
//  JSONGenerator.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 5. 1..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class JSONGenerator {

    private var total: Int = 0
    private var arrayCount: Int = 0
    private var objectCount: Int = 0
    private var numberCount: Int = 0
    private var stringCount: Int = 0
    private var booleanCount: Int = 0
    private var descript = "총"
    
    func upwrapJSON(_ jsonType: JSONType) {
        switch jsonType {
            case .Array(let a):
                upwrapArray(a)
            case .Object(let o):
                upwrapObject(o)
            case .Number(let n):
                upwrapNumber(n)
            case .String(let s):
                upwrapString(s)
            case .Boolean(let b):
                upwrapBoolean(b)
            case .ObjectArray(let oba):
                upwrapObjectArray(oba)
        }
    }
    
    private func upwrapArray(_ jsonArray: [JSONType]) {
        for value in jsonArray {
            if (value.array != nil) {
                self.arrayCount += 1
            }
            upwrapJSON(value)
        }
    }
    
    private func upwrapObject(_ jsonObject: [String: JSONType]) {
        self.objectCount += 1
        for value in jsonObject.values {
            upwrapJSON(value)
        }
    }
    
    private func upwrapString(_ jsonString: String) {
        self.stringCount += 1
    }
    
    private func upwrapNumber(_ jsonNumber: Int) {
        self.numberCount += 1
    }
    
    private func upwrapBoolean(_ jsonBoolean: Bool) {
        self.booleanCount += 1
    }
    
    private func upwrapObjectArray(_ jsonObjectArray: [[String: JSONType]]){
        self.objectCount = jsonObjectArray.count
        for object in jsonObjectArray {
            for value in object.values {
                upwrapJSON(value)
            }
        }
    }
    
    func descriptionMake() -> String {
        
        if arrayCount != 0 {
            descript += " 배열 \(arrayCount) 개"
        }
        
        if objectCount != 0 {
            descript += " 오브젝트 \(objectCount) 개"
        }
        
        if stringCount != 0 {
            descript += " 문자 \(stringCount) 개"
        }
        
        if numberCount != 0 {
            descript += " 숫자 \(numberCount) 개"
        }
        
        if booleanCount != 0 {
            descript += " 부울 \(booleanCount) 개"
        }
        
        descript += "가 포함되어 있습니다."
        
        return descript
    }
}
