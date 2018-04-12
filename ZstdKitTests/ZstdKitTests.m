//
//  ZstdKitTests.m
//  ZstdKitTests
//
//  Created by Micha Mazaheri on 4/12/18.
//  Copyright © 2018 Paw. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LMZstdCompressor.h"

@interface ZstdKitTests : XCTestCase

@end

@implementation ZstdKitTests

#pragma mark - Compress Only

- (void)testCompressEmptyData
{
    XCTAssertNil([LMZstdCompressor compressedDataWithData:[NSData data]]);
}

- (void)testCompressSmallLengthData
{
    XCTAssertNotNil([LMZstdCompressor compressedDataWithData:[NSData dataWithBytes:"luckymarmot" length:11]]);
}

- (void)testCompressNormalLengthData
{
    NSData* originalData = [self makeRandomDataWithLength:1024 * 8]; // 8 kB
    XCTAssertNotNil([LMZstdCompressor compressedDataWithData:originalData]);
}

- (void)testCompressMediumLengthData
{
    NSData* originalData = [self makeRandomDataWithLength:1024 * 64]; // 64 kB
    XCTAssertNotNil([LMZstdCompressor compressedDataWithData:originalData]);
}

- (void)testCompressMediumLengthConstantData
{
    NSData* originalData = [self makeConstantDataWithLength:1024 * 64]; // 64 kB
    NSData* compressedData = [LMZstdCompressor compressedDataWithData:originalData];
    XCTAssertNotNil(compressedData);
    XCTAssertTrue(compressedData.length > 8); // not too small
    XCTAssertTrue(compressedData.length < 1024); // not too large (its a constant data)
}

- (void)testCompressLargeLengthData
{
    // make the data not so random to check compression levels
    NSMutableData* originalData = [[self makeRandomDataWithLength:1024 * 1024] mutableCopy]; // 1 MB
    memset(originalData.mutableBytes + (1024 * 64), '_', 1024 * 256);
    memset(originalData.mutableBytes + (1024 * 700), '-', 1024 * 256);
    
    NSData* compressedData = [LMZstdCompressor compressedDataWithData:originalData];
    XCTAssertNotNil(compressedData);
    XCTAssertTrue(compressedData.length > 1024); // not too small
    XCTAssertTrue(compressedData.length < 1024 * 800); // not too large
}

#pragma mark - Decompress Only

- (void)testDecompressEmptyData
{
    XCTAssertNil([LMZstdCompressor decompressedDataWithData:[NSData data]]);
}

- (void)testDecompressSmallLengthData
{
    NSData* sourceData = [[NSData alloc] initWithBase64EncodedString:@"KLUv/WBLAH0GAGIOJhuAh2kAQERpsSXZf+Tu9uxAQ/qG+jKa7klI3AiDckxpeCnFL9SBoTSS1lRHxeJN+QbrFFYCgYcbV2Aj8QmeV0/4yODpgl445CU9EfAVqeKEAU7YEJJHvWetrbN7th9V6J2e3Fqnjhqh8hVj3hbe6s16Pls37xcbBnh4+lnvzc+WgGn1kyaP4qMjfxifDHj4mXOti6X4mE6DFABnSFJbkK25w2fXay0tpA/YrTuad40fSazcCRwMk7ZU1t5p46d1PusNFS4lGqiwDJd6Ag==" options:kNilOptions];
    NSData* uncompressedData = [LMZstdCompressor decompressedDataWithData:sourceData];
    XCTAssertNotNil(uncompressedData);
    XCTAssertEqualObjects(uncompressedData, [NSData dataWithBytes:"No one wants to die. Even people who want to go to heaven don't want to die to get there. And yet death is the destination we all share. No one has ever escaped it. And that is as it should be, because Death is very likely the single best invention of Life. It is Life's change agent. It clears out the old to make way for the new." length:331]);
}

#pragma mark - Compress And Decompress

- (void)testCompressDecompressMediumLengthData
{
    NSData* originalData = [self makeRandomDataWithLength:1024 * 64]; // 64 kB
    NSData* compressedData = [LMZstdCompressor compressedDataWithData:originalData];
    NSData* decompressedData = [LMZstdCompressor decompressedDataWithData:compressedData];
    XCTAssertNotNil(compressedData);
    XCTAssertNotNil(decompressedData);
    XCTAssertEqualObjects(originalData, decompressedData);
}

- (void)testCompressDecompressMediumLengthConstantData
{
    NSData* originalData = [self makeConstantDataWithLength:1024 * 64]; // 64 kB
    NSData* compressedData = [LMZstdCompressor compressedDataWithData:originalData];
    NSData* decompressedData = [LMZstdCompressor decompressedDataWithData:compressedData];
    XCTAssertNotNil(compressedData);
    XCTAssertNotNil(decompressedData);
    XCTAssertEqualObjects(originalData, decompressedData);
    XCTAssertTrue(compressedData.length > 8); // not too small
    XCTAssertTrue(compressedData.length < 1024); // not too large (its a constant data)
}

- (void)testCompressDecompressLargeLengthData
{
    // make the data not so random to check compression levels
    NSMutableData* originalData = [[self makeRandomDataWithLength:1024 * 1024] mutableCopy]; // 1 MB
    memset(originalData.mutableBytes + (1024 * 64), '_', 1024 * 256);
    memset(originalData.mutableBytes + (1024 * 700), '-', 1024 * 256);
    
    NSData* compressedData = [LMZstdCompressor compressedDataWithData:originalData];
    NSData* decompressedData = [LMZstdCompressor decompressedDataWithData:compressedData];
    XCTAssertNotNil(compressedData);
    XCTAssertNotNil(decompressedData);
    XCTAssertEqualObjects(originalData, decompressedData);
    XCTAssertTrue(compressedData.length > 1024); // not too small
    XCTAssertTrue(compressedData.length < 1024 * 800); // not too large
}

#pragma mark - Performance

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - Helpers

- (NSData*)makeRandomDataWithLength:(NSUInteger)length
{
    uint8_t* buffer = malloc(length * sizeof(size_t));
    if (0 != SecRandomCopyBytes(kSecRandomDefault, (size_t)length * sizeof(size_t), buffer)) {
        free(buffer);
        buffer = NULL;
        return nil;
    }
    NSData* originalData = [NSData dataWithBytes:buffer length:(size_t)length];
    free(buffer);
    buffer = NULL;
    return originalData;
}

- (NSData*)makeConstantDataWithLength:(NSUInteger)length
{
    uint8_t* buffer = malloc(length * sizeof(size_t));
    memset(buffer, '_', length);
    NSData* originalData = [NSData dataWithBytes:buffer length:(size_t)length];
    free(buffer);
    buffer = NULL;
    return originalData;
}

@end
