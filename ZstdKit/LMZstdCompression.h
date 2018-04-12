//
//  LMZstdCompression.h
//  ZstdKit
//
//  Created by Micha Mazaheri on 4/12/18.
//  Copyright © 2018 Paw. All rights reserved.
//

#ifndef LMZstdCompression_h
#define LMZstdCompression_h

#include <CoreFoundation/CFBase.h>
#include <CoreFoundation/CFData.h>

CF_EXPORT int16_t LMZstdCompressionLevelDefault;

/**
 Creates a newly created CFData.
 The input is compressed via the Zstd algorithm.
 
 @param bytes Input bytes.
 @param length Input length (number of bytes).
 @param compressionLevel Compression level (you can pass LMZstdCompressionLevelDefault).
 @return Return the newly created compressed data.
 */
CF_EXPORT CFDataRef LMCreateZstdCompressedData(const void* bytes, CFIndex length, int16_t compressionLevel);

/**
 Creates a newly created CFData.
 The input is decompressed via the Zstd algorithm.
 
 @param bytes Input bytes.
 @param length Input length (number of bytes).
 @return Return the newly created decompressed data.
 */
CF_EXPORT CFDataRef LMCreateZstdDecompressedData(const void* bytes, CFIndex length);

#endif /* LMZstdCompression_h */
