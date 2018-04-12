//
//  LMZstdCompression.c
//  ZstdKit
//
//  Created by Micha Mazaheri on 4/12/18.
//  Copyright © 2018 Paw. All rights reserved.
//

#include "LMZstdCompression.h"

#include <stdio.h>
#include <stdlib.h>

#define ZSTD_STATIC_LINKING_ONLY   // ZSTD_findDecompressedSize
#include "zstd.h"

int16_t LMZstdCompressionLevelDefault = 3 /* ZSTD_CLEVEL_DEFAULT */;

CFDataRef LMCreateZstdCompressedData(const void* bytes, CFIndex length, int16_t compressionLevel)
{
    if (bytes == NULL || length == 0) {
        return NULL;
    }

    // malloc the buffer
    const size_t maxOutputSize = ZSTD_compressBound(length);
    UInt8* outputBuffer = malloc(maxOutputSize);
    
    // compress
    const size_t outputSize = ZSTD_compress(outputBuffer, maxOutputSize, bytes, (size_t)length, (int)compressionLevel);
    
    // if failure, free buffer and return nil
    if (ZSTD_isError(outputSize)) {
        if (outputBuffer != NULL) {
            free(outputBuffer);
            outputBuffer = NULL;
        }
        return NULL;
    }

    // copy output data to a new NSData
    CFDataRef outputData = CFDataCreate(kCFAllocatorDefault, outputBuffer, outputSize);

    // free output buffer
    free(outputBuffer);
    outputBuffer = NULL;

    return outputData;
}

CFDataRef LMCreateZstdDecompressedData(const void* bytes, CFIndex length)
{
    if (bytes == NULL || length == 0) {
        return NULL;
    }

    // find the output size
    unsigned long long outputBufferSize = ZSTD_findDecompressedSize(bytes, length);
    if (ZSTD_CONTENTSIZE_ERROR == outputBufferSize ||
        ZSTD_CONTENTSIZE_UNKNOWN == outputBufferSize) {
        return NULL;
    }

    // malloc the buffer
    UInt8* outputBuffer = malloc((size_t)outputBufferSize);

    // decompress
    size_t outputSize = ZSTD_decompress(outputBuffer, (size_t)outputBufferSize, bytes, length);

    // if invalid output size, return NULL
    if (outputSize != outputBufferSize) {
        if (outputBuffer != NULL) {
            free(outputBuffer);
            outputBuffer = NULL;
        }
        return NULL;
    }

    // copy output data to a new NSData
    CFDataRef outputData = CFDataCreate(kCFAllocatorDefault, outputBuffer, (CFIndex)outputBufferSize);

    // free output buffer
    free(outputBuffer);
    outputBuffer = NULL;

    return outputData;
}
