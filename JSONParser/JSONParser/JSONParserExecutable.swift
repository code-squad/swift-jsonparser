//
//  JSONParserExcutable.swift
//  JSONParser
//
//  Created by 윤지영 on 12/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONParserExecutable {
    func read() -> String?
    func makeResult(of: JSONDataForm)
}

struct JSONLineParser: JSONParserExecutable {

    func read() -> String? {
        let jsonString = InputView.readInput()
        return jsonString
    }
    
    func makeResult(of jsonDataForm: JSONDataForm) {
        OutputView.showJSONPrettyPrinted(of: jsonDataForm)
    }

}

struct JSONFileParser: JSONParserExecutable {

    func read() -> String? {
        guard let file = CommandLineReader.readArgument(atIndex: .inputFile) else { return nil }
        guard let jsonString = FileReader.readContents(from: file) else { return nil }
        return jsonString
    }
    
    func makeResult(of jsonDataForm: JSONDataForm) {
        OutputView.writeJSONPrettyPrinted(of: jsonDataForm)
    }

}
