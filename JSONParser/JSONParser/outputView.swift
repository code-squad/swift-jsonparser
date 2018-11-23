//
//  OutputView.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    // JSONParser에서 전달받은 데이터 세트를 출력
    func printResult(by data: JsonFormat) {
        let dataType = data.name()
        let result = combineSentence(with: (data.countEachJSON()))
        
        print("총 \(result.total)개의 \(dataType) 데이터 중에 \(result.ment)가 포함되어 있습니다.")
    }
    
    // JSON 데이터를 가지고 문장을 조합하는 메소드
    private func combineSentence(with count: (int: Int, bool: Int, string: Int, array: Int, object: Int, total: Int)) -> (total: Int, ment: String) {
        var result = [String]()
        
        if count.int > 0 { result.append("숫자 \(count.int)개") }
        if count.bool > 0 { result.append("부울 \(count.bool)개") }
        if count.string > 0 { result.append("문자열 \(count.string)개") }
        if count.array > 0 { result.append("배열 \(count.array)개") }
        if count.object > 0 { result.append("객체 \(count.object)개") }
        
        let mention = result.joined(separator: ", ")
        return (total: count.total, ment: mention)
    }
}
