import Dependencies
import DependenciesMacros
import Foundation
import Puppy

@DependencyClient
public struct LoggingClient: Sendable {
  public var logTrace:
    @Sendable (
      _ message: String,
      _ tag: String,
      _ function: String,
      _ file: String,
      _ line: UInt
    ) async throws -> Void

  public var logVerbose:
    @Sendable (
      _ message: String,
      _ tag: String,
      _ function: String,
      _ file: String,
      _ line: UInt
    ) async throws -> Void

  public var logDebug:
    @Sendable (
      _ message: String,
      _ tag: String,
      _ function: String,
      _ file: String,
      _ line: UInt
    ) async throws -> Void

  public var logInfo:
    @Sendable (
      _ message: String,
      _ tag: String,
      _ function: String,
      _ file: String,
      _ line: UInt
    ) async throws -> Void

  public var logNotice:
    @Sendable (
      _ message: String,
      _ tag: String,
      _ function: String,
      _ file: String,
      _ line: UInt
    ) async throws -> Void

  public var logWarning:
    @Sendable (
      _ message: String,
      _ tag: String,
      _ function: String,
      _ file: String,
      _ line: UInt
    ) async throws -> Void

  public var logError:
    @Sendable (
      _ message: String,
      _ tag: String,
      _ function: String,
      _ file: String,
      _ line: UInt
    ) async throws -> Void

  public var logCritical:
    @Sendable (
      _ message: String,
      _ tag: String,
      _ function: String,
      _ file: String,
      _ line: UInt
    ) async throws -> Void
}

extension LoggingClient {
  @inlinable
  public func trace(
    _ message: String,
    tag: String = "",
    function: String = #function,
    file: String = #file,
    line: UInt = #line
  ) async throws {
    try await logTrace(message, tag, function, file, line)
  }

  @inlinable
  public func verbose(
    _ message: String,
    tag: String = "",
    function: String = #function,
    file: String = #file,
    line: UInt = #line
  ) async throws {
    try await logVerbose(message, tag, function, file, line)
  }

  @inlinable
  public func debug(
    _ message: String,
    tag: String = "",
    function: String = #function,
    file: String = #file,
    line: UInt = #line
  ) async throws {
    try await logDebug(message, tag, function, file, line)
  }

  @inlinable
  public func info(
    _ message: String,
    tag: String = "",
    function: String = #function,
    file: String = #file,
    line: UInt = #line
  ) async throws {
    try await logInfo(message, tag, function, file, line)
  }

  @inlinable
  public func notice(
    _ message: String,
    tag: String = "",
    function: String = #function,
    file: String = #file,
    line: UInt = #line
  ) async throws {
    try await logNotice(message, tag, function, file, line)
  }

  @inlinable
  public func warning(
    _ message: String,
    tag: String = "",
    function: String = #function,
    file: String = #file,
    line: UInt = #line
  ) async throws {
    try await logWarning(message, tag, function, file, line)
  }

  @inlinable
  public func error(
    _ message: String,
    tag: String = "",
    function: String = #function,
    file: String = #file,
    line: UInt = #line
  ) async throws {
    try await logError(message, tag, function, file, line)
  }

  @inlinable
  public func critical(
    _ message: String,
    tag: String = "",
    function: String = #function,
    file: String = #file,
    line: UInt = #line
  ) async throws {
    try await logCritical(message, tag, function, file, line)
  }
}

extension DependencyValues {
  public var loggingClient: LoggingClient {
    get { self[LoggingClient.self] }
    set { self[LoggingClient.self] = newValue }
  }
}

extension LoggingClient: TestDependencyKey {
  public static let previewValue = Self(
    logTrace: { _, _, _, _, _ in },
    logVerbose: { _, _, _, _, _ in },
    logDebug: { _, _, _, _, _ in },
    logInfo: { _, _, _, _, _ in },
    logNotice: { _, _, _, _, _ in },
    logWarning: { _, _, _, _, _ in },
    logError: { _, _, _, _, _ in },
    logCritical: { _, _, _, _, _ in }
  )

  public static let testValue = Self()
}

enum PuppyError: Error {
  case unableToLocateCacheDirectory
  case unableToCreateConsoleLogger
}

extension LoggingClient: DependencyKey {
  public static let liveValue = {
    () -> Self in
    let puppy = createPuppy()

    return Self(
      logTrace: { message, tag, function, file, line in
        puppy.trace(
          message,
          tag: tag,
          function: function,
          file: file,
          line: line
        )
      },
      logVerbose: { message, tag, function, file, line in
        puppy.verbose(
          message,
          tag: tag,
          function: function,
          file: file,
          line: line
        )
      },
      logDebug: { message, tag, function, file, line in
        puppy.debug(
          message,
          tag: tag,
          function: function,
          file: file,
          line: line
        )
      },
      logInfo: { message, tag, function, file, line in
        puppy.info(
          message,
          tag: tag,
          function: function,
          file: file,
          line: line
        )
      },
      logNotice: { message, tag, function, file, line in
        puppy.notice(
          message,
          tag: tag,
          function: function,
          file: file,
          line: line
        )
      },
      logWarning: { message, tag, function, file, line in
        puppy.warning(
          message,
          tag: tag,
          function: function,
          file: file,
          line: line
        )
      },
      logError: { message, tag, function, file, line in
        puppy.error(
          message,
          tag: tag,
          function: function,
          file: file,
          line: line
        )
      },
      logCritical: { message, tag, function, file, line in
        puppy.critical(
          message,
          tag: tag,
          function: function,
          file: file,
          line: line
        )
      }
    )
  }()

  private static func createPuppy() -> Puppy {
    var puppy = Puppy()

    do {
      guard
        let cacheFileUrl = FileManager.default
          .urls(for: .cachesDirectory, in: .userDomainMask)
          .first?
          .appendingPathComponent("logs")
          .appendingPathComponent("flint.log")
          .absoluteURL
      else { throw PuppyError.unableToLocateCacheDirectory }

      #if DEBUG
        let level = LogLevel.info
      #else
        let level = LogLevel.notice
      #endif

      let fileLogger = try FileRotationLogger(
        "net.4rays.Gameflint.FileLogger",
        logLevel: level,
        logFormat: LogFormatter(),
        fileURL: cacheFileUrl,
        filePermission: "600",
        rotationConfig: .init()
      )

      puppy.add(fileLogger)

      #if DEBUG
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
          let consoleLogger = ConsoleLogger(
            "\(bundleIdentifier).consoleLogger",
            logLevel: .debug,
            logFormat: LogFormatter()
          )

          puppy.add(consoleLogger)
        } else {
          throw PuppyError.unableToCreateConsoleLogger
        }
      #endif
    } catch {
      assertionFailure("Unable to set up logging. Reason: \(error)")
    }

    return puppy
  }
}
