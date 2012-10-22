//
//  PeaceGetImgOperation.m
//  PeaceImageUtil
//
//  Created by zhaoyp on 10/18/12.
//  Copyright (c) 2012 zhaoyp. All rights reserved.
//

#import "PeaceGetImgOperation.h"

@interface PeaceGetImgOperation()

- (void) responseImgInMainThread:(UIImage*)img;

@end

@implementation PeaceGetImgOperation
@synthesize task,delegate;

- (id) initWithImageTask:(PeaceImageTask*)task_ withDelegate:(id<PeaceGetImgOperationProcotol>)delegate_
{
    self = [super init];
    if(self)
    {
        self.task = task_;
        self.delegate = delegate_;
    }
    return self;
}

- (void) main
{
    UIImage* img = [UIImage imageWithContentsOfFile:self.task.cacheImgFilePath];
    if(img)
    {//文件已存在
        [self performSelectorOnMainThread:@selector(responseImgInMainThread:) withObject:img waitUntilDone:NO];
    }
    else
    {//文件不存在，需要重新下载
        NSURL* imgURL = [NSURL URLWithString:self.task.imgUrl];
        NSData* data = [NSData dataWithContentsOfURL:imgURL];
        if(data)
        {
            UIImage* img = [UIImage imageWithData:data];
            if(img)
            {
                [data writeToFile:self.task.cacheImgFilePath atomically:YES];
                [self performSelectorOnMainThread:@selector(responseImgInMainThread:) withObject:img waitUntilDone:NO];
                return;
            }
        }
        //传nil表示下载图片失败
        [self performSelectorOnMainThread:@selector(responseImgInMainThread:) withObject:nil waitUntilDone:NO];
    }
}

- (void) responseImgInMainThread:(UIImage*)img
{
    if([delegate respondsToSelector:@selector(loadImg:forTask:)])
    {
        [delegate  loadImg:img forTask:self.task];
    }
}

- (void) dealloc
{
    [task release];
    [super dealloc];
}
@end
