//
//  YYWeakProxy.h
//  ResponderChain
//
//  Created by gtzhou on 2019/12/7.
//  Copyright © 2019 xyz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYWeakProxy : NSProxy
/**
 The proxy target.
 */
@property (nullable, nonatomic, weak, readonly) id target;
/**
 Creates a new weak proxy for target.
 @param target Target object.
 @return A new proxy object.
 */
- (instancetype)initWithTarget:(id)target;
/**
 Creates a new weak proxy for target.
 @param target Target object.
 @return A new proxy object.
 */
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
