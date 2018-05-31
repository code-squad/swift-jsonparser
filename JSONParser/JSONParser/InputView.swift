//
//  InputView.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 14..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct InputView {    
    /// 사용자 입력값을 받는 함수
    func receiveUserInput() -> String{
        // 입력을 위한 안내 메세지 출력
        print("분석할 JSON 데이터를 입력하세요.")
        guard let userInput =  readLine() else {
            return ""
        }
        return userInput
    }
    
    /// 잘못된 입력일 경우 에러메세지 출력
    func printWrongInputMessage(){
        print ("지원하지 않는 형태입니다.")
    }
    
}
