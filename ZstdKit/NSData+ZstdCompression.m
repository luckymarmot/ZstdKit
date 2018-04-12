//
//  NSData+ZstdCompression.m
//  ZstdKit
//
//  Created by Micha Mazaheri on 4/12/18.
//  Copyright © 2018 Paw. All rights reserved.
//

#import "NSData+ZstdCompression.h"

#import "LMZstdCompressor.h"

@implementation NSData (ZstdCompression)

- (NSData *)compressZstd
{
    return [LMZstdCompressor compressedDataWithData:self];
}

- (NSData *)decompressZstd
{
    return [LMZstdCompressor decompressedDataWithData:self];
}

@end
