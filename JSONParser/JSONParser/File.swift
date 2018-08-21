//
//  OutputFile.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct File {
    private static var _outputFileName:String? = nil
    public static var outputFileName:String? {
        get{
            return _outputFileName
        }
        set(name){
            _outputFileName = name
        }
    }
    
    private static func localPath(_ fileName:String) throws -> URL {
        do {
            let fileManager = FileManager()
            var path = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            path.appendPathComponent(fileName)
            return path
        } catch {
            throw JsonError.pathNotFound
        }
    }
    
    public static func readFile(inputFile: String) throws -> String {
        do {
            let path = try localPath(inputFile)
            let contents = try String(contentsOf: path)
            return contents
        } catch JsonError.pathNotFound {
            throw JsonError.pathNotFound
        } catch {
            throw JsonError.fileNotFound
        }
    }
    
    public static func writeFile(outputFile fileName: String, from data:Jsonable) {
        do {
            let text = data.generateData()
            let path = try localPath(fileName)
            try text.write(to: path, atomically: false, encoding: .utf8)
        } catch JsonError.pathNotFound {
            OutputView.printErrorMessage(error: JsonError.pathNotFound)
        } catch {
            OutputView.printErrorMessage(error: JsonError.unableToCreateFile)
        }
    }
}
