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
