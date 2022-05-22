//
//  main.swift
//  logger
//
//  Created by Marina Roshchupkina on 19.05.2022.
//

import Foundation

enum Level: Int {
case info = 1
case debug = 2
case warning = 3
case error = 4
case fatal = 5
}

protocol LoggerProtocol{
    func log(level: Level, message: String)
}

protocol Writer{
    func write(message: String)
}
final class ConsoleWriter: Writer{
    func write(message: String) {
        print(message)
    }
    
    
}

final class FileWriter: Writer{
    
    static var logFile: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "loggerFile.log"
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    
    func write(message: String) {
        guard let logFile = FileWriter.logFile else {return}
        guard let data = (message+"\n").data(using: String.Encoding.utf8) else { return }
        
        if FileManager.default.fileExists(atPath: logFile.path) {
            if let fileHandle = try? FileHandle(forWritingTo: logFile) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            }
        } else {
            try? data.write(to: logFile, options: .atomicWrite)
        }
    }
    
    
}

// todo console
// todo file

final class Logger: LoggerProtocol{
    private let writers: [Writer]
    private let minLevel: Level
    
    init(writers: [Writer], minlevel: Level){
        self.writers = writers
        self.minLevel = minlevel
    }
    let queue = DispatchQueue(label: "")
    
    func log(level: Level, message: String) {
        if (level.rawValue >= minLevel.rawValue){
            queue.async{
                self.writers.forEach(){writer in
                    writer.write(message: message)
                }
            }
        }
        
    }
    
}

var newLogger = Logger(writers: [ConsoleWriter(),FileWriter()], minlevel: Level.warning)

newLogger.log(level: Level.fatal, message: "should log fatal")
newLogger.log(level: Level.error, message: "should log error")
newLogger.log(level: Level.error, message: "should log warning")
newLogger.log(level: Level.info, message: "should not log")
while true {}
