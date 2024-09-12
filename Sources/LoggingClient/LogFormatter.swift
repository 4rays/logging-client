import Puppy
import Foundation

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

public struct LogFormatter: LogFormattable {
  public init() {}
  
  public func formatMessage(
    _ level: LogLevel,
    message: String,
    tag: String,
    function: String,
    file: String,
    line: UInt,
    swiftLogInfo: [String : String],
    label: String,
    date: Date,
    threadID: UInt64
  ) -> String {
    let date = dateFormatter(date, withFormatter: .init(), dateFormat: "yyyy-MM-dd' | 'HH:mm:ssZZZZZ")
    let file = file.lastPathComponent
#if DEBUG
    return "\(date) \(level.customEmoji) [\(level)] [\(file)@L\(line) \(function) <thread:\(threadID)>] \(message)"
#else
    return "\(date) \(level.customEmoji) [\(level)] \(message)"
#endif
  }
}

extension LogLevel {
  public var customEmoji: String {
    switch self {
    case .trace:
      return "🔲"
    case .verbose:
      return "🔳"
    case .debug:
      return "🟪"
    case .info:
      return "🟦"
    case .notice:
      return "⬜️"
    case .warning:
      return "🟨"
    case .error:
      return "🟥"
    case .critical:
      return "🟧"
    }
  }
}
