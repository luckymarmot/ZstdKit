//
//  NSData+ZstdCompression.h
//  ZstdKit
//
//  Created by Micha Mazaheri on 4/12/18.
//  Copyright © 2018 Paw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ZstdCompression)

- (nullable NSData*)compressZstd;
- (nullable NSData*)decompressZstd;

@end
