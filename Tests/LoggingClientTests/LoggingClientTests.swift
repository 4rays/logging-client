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

  // Generate expected date string using the same formatting as formatMessage
  // This ensures consistency across different locales and timezones
  let expectedDateString = date.formatted(date: .numeric, time: .complete)
  let lineNumber = #line + 7  // Line number where formatMessage is called within #expect

  #expect(
    formatMessage(
      .info,
      message: "Test message.",
      function: #function,
      file: #file,
      line: UInt(lineNumber),
      date: date
    )
      == "\(expectedDateString) 🔵 [INFO] [LoggingClientTests.swift@L\(lineNumber) messageFormatterStandard()] Test message."
  )
}
