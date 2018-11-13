//
//  OutputView.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    // 문자열, 부울, 숫자 각자의 갯수에 맞게 출력
    private func printByType(_ counts: DTO) -> String {
        var result = String()
        let json = counts.json
        let count = json["strings"]!.count + json["ints"]!.count + json["bools"]!.count
        
        if json["strings"]!.count > 0 { result += "문자열 \(json["strings"]!.count)개 " }
        if json["ints"]!.count > 0 { result += "숫자 \(json["ints"]!.count)개 " }
        if json["bools"]!.count > 0 { result += "부울 \(json["bools"]!.count)개 " }
        
        return "총 \(count)개의 데이터 중에 \(result)포함되어 있습니다."
    }
    
    // JSONParser에서 전달받은 데이터 세트를 출력
    func printResult(by counts: DTO) {
        let result = printByType(counts)
        print(result)
    }
}
