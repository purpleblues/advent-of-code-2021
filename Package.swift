// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "advent-of-code-2021",
    platforms: [.macOS(.v12)],
    targets: [
        .executableTarget(name: "day1", resources: [ .copy("input.txt") ]),
        .executableTarget(name: "day2", resources: [ .copy("input.txt") ]),
        .executableTarget(name: "day3", resources: [ .copy("input.txt") ]),
    ]
)
