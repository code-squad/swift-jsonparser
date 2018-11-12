//
//  FileReader.swift
//  JSONParser
//
//  Created by 윤지영 on 12/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct FileReader {

    static func getDocumentURL(with file: String? = nil) -> URL? {
        let documentURL = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        guard let file = file else { return documentURL }
        let documentURLIncludingFile = documentURL?.appendingPathComponent(file)
        return documentURLIncludingFile
    }

    static func readContents(from file: String) -> String? {
        guard let fileURL = getDocumentURL(with: file) else { return nil }
        guard let contents = try? String(contentsOf: fileURL) else { return nil }
        return contents
    }
}
