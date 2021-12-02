// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Geometry2D",
    products: [
        .library(
            name: "Geometry2D",
            targets: [
                "Geometry2D"
            ]
        ),
    ],
    dependencies: [
        .package(
            name: "Angle",
            url: "https://github.com/geonu1109/Angle",
            .exact("1.2.2")
        )
    ],
    targets: [
        .target(
            name: "Geometry2D",
            dependencies: [
                "Angle"
            ]
        ),
        .testTarget(
            name: "Geometry2DTests",
            dependencies: [
                "Geometry2D",
                "Angle"
            ]
        ),
    ]
)
