//
//  ViewController.m
//  Wechat
//
//  Created by Broccoli on 15/11/15.
//  Copyright © 2015年 Broccoli. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *TFCount;
@property (weak, nonatomic) IBOutlet UITextField *TFID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}
- (IBAction)btnClicked:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/pain",@"application/json", nil];
    [manager.requestSerializer setValue:@"le dong li/5.4 (iPhone; iOS 9.1; Scale/2.00)" forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    NSUInteger steps = self.TFCount.text.integerValue;//修改你需要的步数
    NSUInteger ID = self.TFID.text.integerValue;
    NSDate *date = [NSDate new];
    NSUInteger time = [date timeIntervalSince1970];
    NSArray *key = @[@{
                         @"date": @(time),
                         @"calories": @0,
                         @"activeValue": @81,//随便改
                         @"steps": @(steps),
                         @"pm2d5": @0,
                         @"duration": @0,
                         @"distance": @0,
                         @"lat":@0,
                         @"report": @"[]"
                         }];
    NSString *keyStr = [self DataTOjsonString:key];
    NSDictionary *dict = @{
                           @"pc":@"29e39ed274ea8e7a50f8a83abf1239faca843022",
                           @"list": keyStr,
                           @"uid": @(ID)//修改为乐动力app里面的uid
                           };
    
    
    NSString *url = @"http://pl.api.ledongli.cn/xq/io.ashx?&action=profile&cmd=updatedaily&v=5.5%20ios&vc=551%20ios";
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"装逼成功");
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"装逼失败");
        NSLog(@"%@",error);
    }];
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end