// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LoggingClient",
  platforms: [
    .macOS(.v12),
    .iOS(.v16),
    .watchOS(.v8),
    .tvOS(.v16),
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "LoggingClient",
      targets: ["LoggingClient"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.9"),
    .package(url: "https://github.com/sushichop/Puppy", from: "0.7.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "LoggingClient",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DependenciesMacros", package: "swift-dependencies"),
        .product(name: "Puppy", package: "Puppy"),
      ]
    ),
    .testTarget(
      name: "LoggingClientTests",
      dependencies: ["LoggingClient"]
    ),
  ]
)
