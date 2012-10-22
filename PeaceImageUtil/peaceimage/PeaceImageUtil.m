//
//  PeaceImageUtil.m
//  PeaceImageUtil
//
//  Created by zhaoyp on 10/17/12.
//  Copyright (c) 2012 zhaoyp. All rights reserved.
//

#import "PeaceImageUtil.h"
#import "PeaceImageTask.h"
#import "PeaceGetImgOperation.h"

static PeaceImageUtil* instance = nil;
@implementation PeaceImageUtil
@synthesize queue;

+(id) sharedInstance
{
    if(instance==nil)
    {
        instance = [[PeaceImageUtil alloc] init];
    }
    return instance;
}


- (id) init
{
    self = [super init];
    if(self)
    {
        NSOperationQueue* _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 4;
        self.queue = _queue;
        [_queue release];
    }
    return self;
}
- (void) dealloc
{
    [queue cancelAllOperations];
    [queue release];
 
    [super dealloc];
}

- (NSString*) imgCacheDirectory
{
    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* tempPath =  [cachePaths objectAtIndex:0];
    tempPath = [tempPath stringByAppendingPathComponent:@"peaceimgs"];
    return tempPath;
}

- (void) requestImgWithUrl:(NSString*)url forDelegate:(id<PeaceImageUtilProtocol>)delegate
{
    PeaceImageTask* task = [[PeaceImageTask alloc] initWithUrl:url withDelegate:delegate];
    
    PeaceGetImgOperation* operation = [[PeaceGetImgOperation alloc] initWithImageTask:task withDelegate:self];
    [self.queue addOperation:operation];
    [operation release];
    [task release];
}


#pragma mark-
#pragma mark ---PeaceGetImgOperationProcotol Method ---
- (void) loadImg:(UIImage*)img forTask:(PeaceImageTask*)task
{
    if(img)
    {//成功获取到图片
        if([task.imgDelegate respondsToSelector:@selector(loadImgSuccessWithImg:WithDelegate:withUrl:)])
        {
            [task.imgDelegate loadImgSuccessWithImg:img WithDelegate:task.imgDelegate withUrl:task.imgUrl];
        }
    }
    else
    {//获取图片失败
        if([task.imgDelegate respondsToSelector:@selector(loadImgFailedWithDelegate:withUrl:)])
        {
            [task.imgDelegate loadImgFailedWithDelegate:task.imgDelegate withUrl:task.imgUrl];
        }
    }
    
}
@end
