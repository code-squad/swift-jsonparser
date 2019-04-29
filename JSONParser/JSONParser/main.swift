//
//  main.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/26/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

func main () {
    var inputView = InputView()
    var json = [Any]()
    while true {
        inputView.readInput()
        do {
            json = try Converter.inputToAny(inputView.valueEntered)
            break
        }
        catch let error as InputError { print(error.rawValue) }
        catch { print("알 수 없는 오류입니다. 입력값을 확인해주세요.") }
    }
    
    print(Converter.makeMessage(json))
}

main()

