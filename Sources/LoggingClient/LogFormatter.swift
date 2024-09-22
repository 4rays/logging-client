import Foundation
import Logging

extension String {
  var fileURL: URL {
    return URL(fileURLWithPath: self)
  }

  var pathExtension: String {
    return fileURL.pathExtension
  }

  var lastPathComponent: String {
    return fileURL.lastPathComponent
  }
}

public func formatMessage(
  _ level: Logger.Level,
  message: String,
  function: String,
  file: String,
  line: UInt,
  date: Date
) -> String {
  let dateString = date.formatted(date: .numeric, time: .complete)
  let file = file.lastPathComponent
#if DEBUG
  return "\(dateString) \(level.customEmoji) [\(level.rawValue.uppercased())] [\(file)@L\(line) \(function)] \(message)"
#else
  return "\(date) \(level.customEmoji) [\(level)] \(message)"
#endif
}

extension Logger.Level {
  public var customEmoji: String {
    switch self {
    case .trace: "🛞"
    case .debug: "🟣"
    case .info: "🔵"
    case .notice: "⚪"
    case .warning: "🟡"
    case .error: "🔴"
    case .critical: "⭕"
    }
  }
}
