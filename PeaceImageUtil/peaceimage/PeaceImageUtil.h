//
//  PeaceImageUtil.h
//  PeaceImageUtil
//
//  Created by zhaoyp on 10/17/12.
//  Copyright (c) 2012 zhaoyp. All rights reserved.
//
/*
 * 1.根据指定的url，判断本地cache目录是否存在对应的图片。如果存在，则直接将图片返回给请求方。如果不存在，则从远程服务器端下载图片。
 * 2.将图片保存在本地的cache目录，
 * 3.将图片返回给请求方。
 */

#import <Foundation/Foundation.h>
#import "PeaceGetImgOperation.h"


@protocol PeaceImageUtilProtocol <NSObject>

- (void) loadImgSuccessWithImg:(UIImage*)img WithDelegate:(id<PeaceImageUtilProtocol>)delegate withUrl:(NSString*)url;

- (void) loadImgFailedWithDelegate:(id<PeaceImageUtilProtocol>)delegate withUrl:(NSString*)url;
@end

@interface PeaceImageUtil : NSObject <PeaceGetImgOperationProcotol>

@property (nonatomic,retain) NSOperationQueue* queue;


+(id) sharedInstance;

//download image
- (void) requestImgWithUrl:(NSString*)url forDelegate:(id<PeaceImageUtilProtocol>)delegate;

- (NSString*) imgCacheDirectory;

@end
