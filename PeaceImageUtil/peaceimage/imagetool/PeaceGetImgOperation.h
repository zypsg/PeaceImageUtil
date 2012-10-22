//
//  PeaceGetImgOperation.h
//  PeaceImageUtil
//
//  Created by zhaoyp on 10/18/12.
//  Copyright (c) 2012 zhaoyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeaceImageTask.h"

@protocol PeaceGetImgOperationProcotol <NSObject>

- (void) loadImg:(UIImage*)img forTask:(PeaceImageTask*)task;

@end

@interface PeaceGetImgOperation : NSOperation 

@property (nonatomic,retain) PeaceImageTask* task;
@property (nonatomic,assign) id<PeaceGetImgOperationProcotol> delegate;

- (id) initWithImageTask:(PeaceImageTask*)task withDelegate:(id<PeaceGetImgOperationProcotol>)delegate_;
@end
