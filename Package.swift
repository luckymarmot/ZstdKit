// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "ZstdKit",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "ZstdKit",
            targets: ["ZstdKit"]
        )
    ],
    targets: [
        .target(
            name: "ZstdKit",
            dependencies: ["zstd"],
            path: "ZstdKit",
            publicHeadersPath: ".",
            cSettings: [
                .unsafeFlags(["-DCLANG_WARN_COMMA=0"]),
                .unsafeFlags(["-DCLANG_WARN_UNREACHABLE_CODE=0"])
            ]
        ),
        .target(
            name: "zstd",
            path: "Sources/zstd",
            sources: [
                "common/entropy_common.c",
                "common/error_private.c",
                "common/fse_decompress.c",
                "common/pool.c",
                "common/threading.c",
                "common/xxhash.c",
                "common/zstd_common.c",
                "compress/fse_compress.c",
                "compress/huf_compress.c",
                "compress/zstd_compress.c",
                "compress/zstd_double_fast.c",
                "compress/zstd_fast.c",
                "compress/zstd_lazy.c",
                "compress/zstd_ldm.c",
                "compress/zstd_opt.c",
                "compress/zstdmt_compress.c",
                "decompress/huf_decompress.c",
                "decompress/zstd_decompress.c"
            ],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("common"),
                .headerSearchPath("compress"),
                .headerSearchPath("decompress"),
                .unsafeFlags(["-DCLANG_WARN_COMMA=0"]),
                .unsafeFlags(["-DCLANG_WARN_UNREACHABLE_CODE=0"])
            ]
        ),
        .testTarget(
            name: "ZstdKitTests",
            dependencies: ["ZstdKit"],
            path: "ZstdKitTests"
        )
    ]
)