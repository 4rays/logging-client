# LoggingClient

A dependency client that handles file logs in apps using the Swift Composable Architecture (TCA).

## Usage

- `logTrace` Logs trace-level messages, typically used for detailed debugging information.
- `logVerbose` Logs verbose-level messages, providing more detailed information than debug logs.
- `logDebug` Logs debug-level messages, useful for debugging during development.
- `logInfo` Logs informational messages, typically used to report normal but significant events.
- `logNotice` Logs notice-level messages, indicating normal but noteworthy conditions.
- `logWarning` Logs warning-level messages, indicating potential issues or important situations that are not errors.
- `logError` Logs error-level messages, indicating errors that might still allow the application to continue running.
- `logCritical` Logs critical-level messages, indicating severe errors that will presumably lead the application to abort.

To get started, you need to configure the logger using the `LoggingConfigClient`.
You can achieve that in your app by implementing a `liveValue` from scratch, or using the
provided `defaultValue` that comes with this library.

```swift
extension LoggingConfigClient: DependencyValue {
  static let liveValue = defaultValue
}
```

The default value uses a `LoggingClient` label, saves the log files in the caches
directory, and caps the size of a logs file to 10mb.
