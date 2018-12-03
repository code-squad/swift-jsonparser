//
//  FileReader.swift
//  JSONParser
//
//  Created by 윤동민 on 30/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct FileReaderWriter {
    // 파일을 읽어온다
    static func readFile(in fileName : String) -> String? {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentURL.appendingPathComponent("\(fileName)")
        guard let readText = try? String(contentsOf: fileURL, encoding: .utf8) else { return nil }
        return readText
    }
    
    // 파일을 저장한다
    static func writeFile(on fileName : String, with text : String) {
        let documetnURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var fileURL : URL
        fileURL = documetnURL.appendingPathComponent(fileName)
        try? text.write(to: fileURL, atomically: true, encoding: .utf8)
    }
}
