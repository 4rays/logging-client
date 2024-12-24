import ComposableArchitecture

extension Reducer {
  public func tcaLogs() -> some Reducer {
    self._printChanges(.swiftLog(label: "TCA"))
  }
}
