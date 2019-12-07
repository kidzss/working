//
//  EventProxy.h
//  ResponderChain
//
//  Created by gtzhou on 2019/12/1.
//  Copyright © 2019 xyz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventProxy : NSObject
- (void)handleEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
