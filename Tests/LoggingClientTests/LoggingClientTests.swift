import Foundation
import Logging
import Testing

@testable import LoggingClient

@Test(arguments: Logger.Level.allCases)
func messageFormatter(_ level: Logger.Level) {
  let date = Date()
  #expect(
    formatMessage(
      level,
      message: "Test message.",
      function: #function,
      file: #file,
      line: #line,
      date: date
    )
      == "\(date.formatted(date: .numeric, time: .complete)) \(level.customEmoji) [\(level.rawValue.uppercased())] [\(#file.lastPathComponent)@L\(#line) \(#function)] Test message."
  )
}

@Test func messageFormatterStandard() {
  let date = Date(timeIntervalSince1970: 0)

  #expect(
    formatMessage(
      .info,
      message: "Test message.",
      function: #function,
      file: #file,
      line: #line,
      date: date
    )
      == "1970-01-01, 1:00:00 GMT+1 🔵 [INFO] [LoggingClientTests.swift@L26 messageFormatterStandard()] Test message."
  )
}
