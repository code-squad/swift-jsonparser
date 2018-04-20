//
//  OutputView.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

struct OutputView {
    
    static func ask() {
        print(JSONPASER_QUESTION_INPUT)
    }
    
    static func errorMessage(of e: JSONPaserErorr) {
        print(e.rawValue)
    }
    
    static func resultShow(_ resultJSON: JSONData) {
        print(resultJSON.descriptionShow())
    }
}
