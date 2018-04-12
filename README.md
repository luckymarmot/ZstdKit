# ZstdKit

An Objective-C and Swift library for Zstd (Zstandard) compression and decompression.

## Installation

Via Cocoapods:

```
pod 'ZstdKit'
```

## Usage

### `NSData` category

```objc
// compression
[myData compressZstd];

// decompression
[myData decompressZstd];
```

### Compressor class

Simple usage

```objc
// compression
[LMZstdCompressor compressedDataWithData:myData];

// decompression
[LMZstdCompressor decompressedDataWithData:myData];
```

Compression level

```objc
// compression
[LMZstdCompressor compressedDataWithData:myData compressionLevel:3];
```

### Core Foundation API

```c
CF_EXPORT CFDataRef LMCreateZstdCompressedData(const void* bytes, CFIndex length, int16_t compressionLevel);
CF_EXPORT CFDataRef LMCreateZstdDecompressedData(const void* bytes, CFIndex length);
```

## License

The original [Zstandard code](https://github.com/facebook/zstd) is licensed under the [BSD license](https://github.com/facebook/zstd/blob/dev/LICENSE). This code is licensed under the MIT license.
