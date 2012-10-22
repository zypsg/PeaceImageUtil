//
//  PeaceImageTask.h
//  PeaceImageUtil
//
//  Created by zhaoyp on 10/18/12.
//  Copyright (c) 2012 zhaoyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PeaceImageUtilProtocol;
@interface PeaceImageTask : NSObject
 
@property (nonatomic,retain) NSString* imgUrl;
@property (nonatomic,retain) NSString* cacheImgFilePath;
@property (nonatomic,assign) id<PeaceImageUtilProtocol> imgDelegate;

- (id) initWithUrl:(NSString*)url withDelegate:(id<PeaceImageUtilProtocol> )delegate;
@end
