//
//  PeaceImageTask.m
//  PeaceImageUtil
//
//  Created by zhaoyp on 10/18/12.
//  Copyright (c) 2012 zhaoyp. All rights reserved.
//

#import "PeaceImageTask.h"
#import <CommonCrypto/CommonDigest.h>
#import "PeaceImageUtil.h"

@interface PeaceImageTask()

+ (NSString*) MD5Digest:(NSString*)srcStr;

@end

@implementation PeaceImageTask
@synthesize imgUrl,imgDelegate;
@synthesize cacheImgFilePath;

- (id) initWithUrl:(NSString*)url withDelegate:(id<PeaceImageUtilProtocol> )delegate
{
    self = [super init];
    if(self)
    {
        if(!url)
        {
            url=@"";
        }
        url = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, nil, nil, kCFStringEncodingUTF8);
        
        self.imgUrl = url;
        self.imgDelegate = delegate;
        if(self.imgUrl)
        {
            NSString* cacheDirectory = [[PeaceImageUtil sharedInstance] imgCacheDirectory];
            NSFileManager* manager = [NSFileManager defaultManager];
            BOOL isDirectory = NO;
            BOOL exist = [manager fileExistsAtPath:cacheDirectory isDirectory:&isDirectory];
            if(!exist||!isDirectory)
            {
                [manager createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
            }
 
            self.cacheImgFilePath = [NSString stringWithFormat:@"%@/%@.png",cacheDirectory,[[self class] MD5Digest:self.imgUrl]];
        }
    }
    return self;
}

- (void) dealloc
{
    self.cacheImgFilePath = nil;
    [imgUrl release];
    [super dealloc];
}

+ (NSString*) MD5Digest:(NSString*)srcStr
{
    if ([srcStr length] == 0 ) {
        return nil;
    }
    const char *cStr = [srcStr UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
