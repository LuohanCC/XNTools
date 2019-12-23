//
//  NSData+SDDataCache.m
//  XNTools
//
//  Created by aier on 15-3-30.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "NSData+XNDataCache.h"
#import <CommonCrypto/CommonDigest.h>

#define kSDMaxCacheFileAmount 100

@implementation NSData (XNDataCache)

+ (NSString *)cachePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"Caches"];
    path = [path stringByAppendingPathComponent:@"SDDataCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)md5HashOfPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Make sure the file exists
    if( [fileManager fileExistsAtPath:path isDirectory:nil] ) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5( data.bytes, (CC_LONG)data.length, digest );
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for( int i = 0; i < CC_MD5_DIGEST_LENGTH; i++ ) {
            [output appendFormat:@"%02x", digest[i]];
        }
        return output;
    } else {
        return @"";
    }
}


//- (void)saveDataCacheWithIdentifier:(NSString *)identifier
//{
//    NSString *path = [NSData creatDataPathWithString:identifier];
//    [self writeToFile:path atomically:YES];
//}

//+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier
//{
//    static BOOL isCheckedCacheDisk = NO;
//    if (!isCheckedCacheDisk) {
//        NSFileManager *manager = [NSFileManager defaultManager];
//        NSArray *contents = [manager contentsOfDirectoryAtPath:[self cachePath] error:nil];
//        if (contents.count >= kSDMaxCacheFileAmount) {
//            [manager removeItemAtPath:[self cachePath] error:nil];
//        }
//        isCheckedCacheDisk = YES;
//    }
//    NSString *path = [self creatDataPathWithString:identifier];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    return data;
//}

//+ (void)clearCache
//{
//    NSFileManager *manager = [NSFileManager defaultManager];
//    [manager removeItemAtPath:[self cachePath] error:nil];
//}

@end
