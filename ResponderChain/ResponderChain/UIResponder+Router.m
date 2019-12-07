//
//  UIResponder+Router.m
//  ResponderChain
//
//  Created by gtzhou on 2019/12/1.
//  Copyright © 2019 xyz. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName
                   userInfo:(NSDictionary *)userInfo{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
    // 如果需要让事件继续往上传递，则调用下面的语句
    // [super routerEventWithName:eventName userInfo:userInfo];
}

@end
