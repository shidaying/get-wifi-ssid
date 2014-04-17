//
//  ViewController.m
//  获取Wifi SSID
//
//  Created by hour on 14-4-15.
//  Copyright (c) 2014年 上海思墨信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)fetchSSIDInfo
{
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    NSLog(@"%s: Supported interfaces: %@", __func__, ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
//        [info release];
    }
//    [ifs release];
    return info;
//    return [info autorelease];
}

- (NSString *)currentWifiSSID {
    // Does not work on the simulator.
    NSString *ssid = nil;
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    NSLog(@"ifs:%@",ifs);
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"dici：%@",[info  allKeys]);
        if (info[@"SSIDD"]) {
            ssid = info[@"SSID"];
            
        }
    }
    return ssid;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *infoLabel =[[UILabel alloc]initWithFrame:CGRectMake(50, 40, 200, 40)];
    infoLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:infoLabel];
    NSDictionary *ifs = [self fetchSSIDInfo];
    NSLog(@"ifs = %@",ifs);
    NSString *ssid = [ifs objectForKey:@"SSID"];
    infoLabel.text=ssid;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
