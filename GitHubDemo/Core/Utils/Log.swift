//
//  Log.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 1/10/24.
//

import OSLog

public final class Log {

    static let logger = Logger(subsystem: "DentalApp", category: "main")

    public static func debug(_ message: String?) {
        guard let message = message else { return }
        #if DEBUG
        logger.log(level: .debug, "\(message)")
        #endif
    }

    public static func info(_ message: String?) {
        guard let message = message else { return }
        logger.log(level: .info, "\(message)")
    }

    public static func `default`(_ message: String?) {
        guard let message = message else { return }
        logger.log(level: .default, "\(message)")
    }

    public static func error(_ message: String?) {
        guard let message = message else { return }
        logger.log(level: .error, "\(message)")
    }

    public static func fault(_ message: String?) {
        guard let message = message else { return }
        logger.log(level: .fault, "\(message)")
    }
}
