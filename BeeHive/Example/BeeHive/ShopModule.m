//
//  ShopModule.m
//  BeeHive
//
//  Created by DP on 16/3/17.
//  Copyright © 2016年 一渡. All rights reserved.
//

#import "ShopModule.h"
#import "BeeHive.h"

//使用注解的方式注册
@BeeHiveMod(ShopModule)

@interface ShopModule() <BHModuleProtocol>

@end

@implementation ShopModule

- (id)init {
    if (self = [super init]) {
        NSLog(@"ShopModule init");
    }
    
    return self;
}

- (NSUInteger)moduleLevel {
    return 0;
}

- (void)modInit:(BHContext *)context {
    NSLog(@"ShopModule modInit");
}

- (void)modSplash:(BHContext *)context{
    NSLog(@"ShopModule modSplash");
}

- (void)modSetUp:(BHContext *)context {
    NSLog(@"ShopModule setup");
}

@end
