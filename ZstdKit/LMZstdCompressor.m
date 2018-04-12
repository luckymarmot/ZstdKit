//
//  LMZstdCompressor.m
//  ZstdKit
//
//  Created by Micha Mazaheri on 4/12/18.
//  Copyright © 2018 Paw. All rights reserved.
//

#import "LMZstdCompressor.h"

#import "LMZstdCompression.h"

@implementation LMZstdCompressor

+ (NSInteger)defaultCompressionLevel
{
    return LMZstdCompressionLevelDefault;
}

+ (NSData*)compressedDataWithData:(NSData*)input
{
    return [self compressedDataWithData:input compressionLevel:self.defaultCompressionLevel];
}

+ (NSData*)compressedDataWithData:(NSData*)input compressionLevel:(NSInteger)compressionLevel
{
    return [self compressedDataWithBytes:input.bytes length:input.length compressionLevel:compressionLevel];
}

+ (NSData*)compressedDataWithBytes:(const void*)bytes length:(NSUInteger)length
{
    return [self compressedDataWithBytes:bytes length:length compressionLevel:self.defaultCompressionLevel];
}

+ (NSData*)compressedDataWithBytes:(const void*)bytes length:(NSUInteger)length compressionLevel:(NSInteger)compressionLevel
{
    return CFBridgingRelease(LMCreateZstdCompressedData(bytes, length, compressionLevel));
}

+ (NSData*)decompressedDataWithData:(NSData*)input
{
    return [self decompressedDataWithBytes:input.bytes length:input.length];
}

+ (NSData*)decompressedDataWithBytes:(const void*)bytes length:(NSUInteger)length
{
    return CFBridgingRelease(LMCreateZstdDecompressedData(bytes, length));
}

@end
