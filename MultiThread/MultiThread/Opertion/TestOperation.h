//
//  TestOperation.h
//  MultiThread
//
//  Created by gtzhou on 2020/1/1.
//  Copyright © 2020 xyz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestOperation : NSOperation
@property (nonatomic, copy) id obj;
- (instancetype)initWithObject:(id)obj;
@end

NS_ASSUME_NONNULL_END
