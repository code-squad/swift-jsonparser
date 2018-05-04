//
//  JSON.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 26..
//  Copyright © 2018년 JK. All rights reserved.
//

protocol JSON {
    init?(_ jsonType: JSONType)
    func descriptionShow() -> String
}
