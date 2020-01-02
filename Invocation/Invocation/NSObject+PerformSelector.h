//
//  NSObject+PerformSelector.h
//  Invocation
//
//  Created by gtzhou on 2019/12/15.
//  Copyright © 2019 xyz. All rights reserved.
//  使用performSelector导致内存问题

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PerformSelector)

- (id)performSelector:(SEL)aSelector withParams:(NSArray*)objects;

@end

NS_ASSUME_NONNULL_END
