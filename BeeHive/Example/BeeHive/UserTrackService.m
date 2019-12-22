//
//  UserTrackService.m
//  BeeHive_Example
//
//  Created by gtzhou on 2019/12/22.
//  Copyright © 2019 一渡. All rights reserved.
//  UserTrack Module的具体serviceImpl
#import "BeeHive.h"
#import "BHService.h"
#import "UserTrackService.h"
#import "UserTrackServiceProtocol.h"
#import "BHUserTrackViewController.h"

//使用注解的方式注册
@BeeHiveService(UserTrackServiceProtocol,UserTrackService)

@interface UserTrackService()<UserTrackServiceProtocol>

@end

@implementation UserTrackService

- (UIViewController *)fetchUserTrackViewController:(NSDictionary *)params {
    BHUserTrackViewController *vc = BHUserTrackViewController.new;
    vc.title = params[@"key"]?:@"UserTrack";
    return vc;
}

+ (BOOL)singleton {
    return NO;
}


@end
