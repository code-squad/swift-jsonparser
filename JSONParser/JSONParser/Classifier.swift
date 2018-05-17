//
//  Classifier.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 15..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Classifier{
    /// 문자열을 받아서 쉼표를 기준으로 나누어 배열로 생성한다
    func test(letters : String) -> [String] {
        // 쉼표 다음지점을 체크하기 위한 플래그
        var indexFlag = input.startIndex
        // 결롸 리언용 배열
        var result : [String] = []
        //입력받은 문자열 전체를 돈다
        repeat {
            // 쉼표 위치 변수. 쉼표가 없을경우 문자열의 끝을 표시
            let commaPosition = input[indexFlag..<input.endIndex].index(of: ",") ?? input.endIndex
            // 해당 부분을 잘라서 문자형 배열에 추가
            result.append(String(input[indexFlag..<commaPosition]))
            // 쉼표 위치 변수가 문자열의 마지막이 아니면 == 뒤에 더 있다면
            if commaPosition != input.endIndex {
                // 쉼표 다음 글자를 가리킨다
                indexFlag = input.index(after:commaPosition)
            // 마지막일 경우
            } else {
                // 문자열의 마지막을 가리킨다
                indexFlag = input.endIndex
            }
            // 위치 체크용 플래그가 문자열의 마지막을 가리키면 반복문 종료
        } while indexFlag != input.endIndex
        // 결과를 리턴한다
        return result
    }
}
