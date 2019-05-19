//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation


var tknr = MyTokenizer()
_ = try tknr.tokenize("[ \"Hi, jk\", 4, false,]")


//
//입력받아 -> String
//
//분석해 -> [Token]
//컨텍스트 파악해  A
//컨텍스트동안 데이터 저장해
//새로운 컨텍스트 만나 -> 우선순위 보고 내 하위에 올수 있으면  A 로 건너뛰어
//컨텍스트 끝나 -> 컨텍스트랑 데이터로 토큰 만들고
//반복해
//
//
//토큰의 타입들 카운트해 -> Int
//
//출력해
//
//
//우선순위 -
//    배열 = 컨테이너 , 엘리먼트
//오브젝트  = 컨테이너 , 엘리먼트
//나머지 = 엘리먼트
//
//문자열 - 특수화 - > 자기 메타데이터 뺴고 모두 무시
