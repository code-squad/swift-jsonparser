//
//  InputView.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 2..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct InputView {
    // 입력값 받는 함수
    public static func readInput() -> String? {
        print("분석할 JSON 데이터를 입력하세요.")
        return readLine()
    }
    
    // 입력값 비어 있는지 확인하는 함수
    public static func isEmpty(to value:String?) -> String? {
        guard let inputValue = value else { return nil }
        if inputValue.isEmpty {
            print("값이 비어있습니다. 다시 입력해주세요.")
            return nil
        }
        return inputValue
    }
    
    public static func readFile(inputFile: String , outputFile: String?) throws -> String {
        let fileManager = FileManager()
        
        do {
            var path = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            path.appendPathComponent(inputFile)
            path.appendPathComponent("d")
            let contents = try String(contentsOf: path)
            return contents
        } catch {
            throw JsonError.fileNotFound
        }
    }
    
    public static func writeFile() {
        
    }
    
}
