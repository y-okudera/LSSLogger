//
//  LSSLogger.swift
//  LSSLogger
//
//  Created by YukiOkudera on 2018/05/13.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

private enum DateFormat: String {
    case logHeader = "yyyy/MM/dd HH:mm:ss:SSS"
    case logFileName = "yyyy_MM_dd"
}

private enum LogLevel: String {
    case debug = "[DEBUG]"
    case info = "[INFO]"
    case warning = "[WARNING]"
    case error = "[ERROR]"
    case fatal = "[FATAL]"
}

private enum EmojiForEachLogLevel: String {
    case debug = "🐥"
    case info = "🔔"
    case warning = "⚠️"
    case error = "‼️"
    case fatal = "💔"

    static func fromLogLevel(logLevel: LogLevel) -> EmojiForEachLogLevel {

        switch logLevel {
        case .debug:
            return .debug
        case .info:
            return .info
        case .warning:
            return .warning
        case .error:
            return .error
        case .fatal:
            return .fatal
        }
    }
}

public enum DestinationOfTheLog {
    case console
    case file
    case consoleAndFile
}

final class LSSLogger {

    private static let defaultLogRotationCount: UInt = 10
    public static let console = LSSLogger()
    public static let file = LSSLogger(destination: .file)
    public static let consoleAndFile = LSSLogger(destination: .consoleAndFile)
    public static var logRotationCount: UInt = defaultLogRotationCount

    private let destination: DestinationOfTheLog

    private init(destination: DestinationOfTheLog = .console) {
        self.destination = destination
    }

    /// Set the log rotation count.
    public static func configureLogRotationCount(count: UInt) {
        LSSLogger.logRotationCount = count
    }

    /// Debug log.
    public func debug(message: String = "", function: String = #function, file: String = #file, line: Int = #line) {
        #if DEBUG
        write(loglevel: .debug, message: message, function: function, file: file, line: line)
        #endif
    }

    /// Info log.
    public func info(message: String = "", function: String = #function, file: String = #file, line: Int = #line) {
        write(loglevel: .info, message: message, function: function, file: file, line: line)
    }

    /// Warning log.
    public func warning(message: String = "", function: String = #function, file: String = #file, line: Int = #line) {
        write(loglevel: .warning, message: message, function: function, file: file, line: line)
    }

    /// Error log.
    public func error(message: String = "", function: String = #function, file: String = #file, line: Int = #line) {
        write(loglevel: .error, message: message, function: function, file: file, line: line)
    }

    /// Fatal log.
    public func fatal(message: String = "", function: String = #function, file: String = #file, line: Int = #line) {
        write(loglevel: .fatal, message: message, function: function, file: file, line: line)
    }

    // MARK: - Private Methods

    // MARK: Log

    /// Output the log.
    private func write(loglevel: LogLevel, message: String, function: String, file: String, line: Int) {

        let now = Date().toStr(dateFormat: DateFormat.logHeader.rawValue)
        var filename = file
        if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
            filename = String(filename[match])
        }

        let emoji = EmojiForEachLogLevel.fromLogLevel(logLevel: loglevel).rawValue
        writeToConsole(
            date: now,
            loglevel: loglevel,
            message: message,
            function: function,
            filename: filename,
            line: line,
            emoji: emoji
        )

        writeToFile(
            date: now,
            loglevel: loglevel,
            message: message,
            function: function,
            filename: filename,
            line: line
        )
    }

    /// When the destination is .console or .consoleAndFile, output log to console.
    private func writeToConsole(date: String,
                                loglevel: LogLevel,
                                message: String,
                                function: String,
                                filename: String,
                                line: Int,
                                emoji: String) {

        if destination == .file {
            return
        }

        let emoji = EmojiForEachLogLevel.fromLogLevel(logLevel: loglevel).rawValue
        let consoleLog = formatLog(
            date: date,
            loglevel: loglevel,
            message: message,
            function: function,
            filename: filename,
            line: line,
            emoji: emoji
        )
        print(consoleLog)
    }

    /// When the destination is .file or .consoleAndFile, output log to file.
    private func writeToFile(date: String,
                             loglevel: LogLevel,
                             message: String,
                             function: String,
                             filename: String,
                             line: Int) {

        if destination == .console {
            return
        }

        let fileLog = formatLog(
            date: date,
            loglevel: loglevel,
            message: message,
            function: function,
            filename: filename,
            line: line
        )

        createDailyLogDirectoryIfNeeded()
        let todayLogFilePath = self.todayLogFilePath()

        if existsTodayLog() {

            guard
                let fileHandle = FileHandle(forWritingAtPath: todayLogFilePath),
                let textData = ("\n" + fileLog).data(using: .utf8) else {
                    return
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(textData)

        } else {

            removeTheOldestLogFileIfNeeded()

            try? fileLog.write(
                toFile: todayLogFilePath,
                atomically: true,
                encoding: .utf8
            )
        }
    }

    /// Format the log.
    private func formatLog(date: String,
                           loglevel: LogLevel,
                           message: String,
                           function: String,
                           filename: String,
                           line: Int,
                           emoji: String? = nil) -> String {

        if let emoji = emoji {
            let consoleLog = "\(date) \(emoji)\(loglevel.rawValue) \(function) @\(filename)(Line \(line))"
            return message.isEmpty ? consoleLog + emoji : consoleLog + " > \(message)" + emoji

        } else {
            let fileLog = "\(date) \(loglevel.rawValue) \(function) @\(filename)(Line \(line))"
            return message.isEmpty ? fileLog : fileLog + " > \(message)"
        }
    }

    // MARK: Directory

    /// Get the path of the directory storing the daily log file.
    ///
    /// - Returns: ~/Documents/DAILY_LOG
    private func dailyLogDirectory() -> String {
        let dailyLogDirectoryName = "DAILY_LOG"
        return String.documentsDirectory().appendingPathComponent(dailyLogDirectoryName)
    }

    /// If there is no directory to store the daily log file, create it.
    private func createDailyLogDirectoryIfNeeded() {

        let dailyLogDirectory = self.dailyLogDirectory()
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dailyLogDirectory) {
            do {
                try fileManager.createDirectory(
                    atPath: dailyLogDirectory,
                    withIntermediateDirectories: false,
                    attributes: nil
                )
            } catch let e {
                fatalError(e.localizedDescription)
            }
        }
    }

    // MARK: File

    /// Get the path of the log file for the current day.
    ///
    /// - Returns: ~/Documents/DAILY_LOG/yyyy_MM_dd.log
    private func todayLogFilePath() -> String {

        let today = Date().toStr(dateFormat: DateFormat.logFileName.rawValue)
        return dailyLogDirectory().appendingPathComponent("\(today).log")
    }

    /// Get the path of the log file in ascending order.
    ///
    /// - Returns: Array of log files PATH.
    private func allLogs() -> [String]? {

        let dailyLogDirectory = self.dailyLogDirectory()
        do {
            let allLogs = try FileManager.default.contentsOfDirectory(atPath: dailyLogDirectory)
            var absolutePathOfLogs = allLogs.map {
                self.dailyLogDirectory().appendingPathComponent($0)
            }
            // sort in ascending order
            absolutePathOfLogs.sort()

            return absolutePathOfLogs

        } catch {
            return nil
        }
    }

    /// If the log file exists more than the log rotation count, remove the oldest file.
    private func removeTheOldestLogFileIfNeeded() {

        var allLogs = self.allLogs()
        while allLogs?.count ?? 0 >= LSSLogger.logRotationCount {
            guard let theOldestLogFile = allLogs?.first else {
                break
            }
            do {
                try FileManager.default.removeItem(atPath: theOldestLogFile)
            } catch {
                break
            }
            allLogs = self.allLogs()
        }
    }

    /// Whether there exist log files for the current day.
    ///
    /// - Returns: true: exist., false: not exist
    private func existsTodayLog() -> Bool {
        return FileManager.default.fileExists(atPath: todayLogFilePath())
    }
}
