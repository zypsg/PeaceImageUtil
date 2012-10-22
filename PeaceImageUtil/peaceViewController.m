//
//  peaceViewController.m
//  PeaceImageUtil
//
//  Created by zhaoyp on 10/17/12.
//  Copyright (c) 2012 zhaoyp. All rights reserved.
//

#import "peaceViewController.h"

@interface peaceViewController ()

@property (nonatomic,retain) IBOutlet UIImageView* IV;

- (IBAction)downloadImg:(id)sender;

@end

@implementation peaceViewController
@synthesize IV;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    self.IV = nil;
    [super dealloc];
}


- (IBAction)downloadImg:(id)sender
{
    NSString* url = @"http://m1.img.libdd.com/farm3/175/f7c61691eb8b555989d4d15bd7ecaeaf_500_407.jpg";
    PeaceImageUtil* imgUtil = [PeaceImageUtil sharedInstance];
    [imgUtil requestImgWithUrl:url forDelegate:self];
}
 

#pragma mark-
#pragma mark---PeaceImageUtilProtocol Delegate Methods ---
- (void) loadImgSuccessWithImg:(UIImage*)img WithDelegate:(id<PeaceImageUtilProtocol>)delegate withUrl:(NSString*)url
{
    self.IV.image=img;
}

- (void) loadImgFailedWithDelegate:(id<PeaceImageUtilProtocol>)delegate withUrl:(NSString*)url
{
    NSLog(@"loadImgFailedWithDelegate...%@,url:%@",delegate,url);
}
@end
