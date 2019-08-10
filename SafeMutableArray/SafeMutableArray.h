//
//  SafeMutableArray.h
//  
//
//  Created by 周刚涛 on 2018/12/30.
//  Copyright © 2018年 xyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SafeMutableArray : NSMutableArray
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithCapacity:(NSUInteger)numItems NS_DESIGNATED_INITIALIZER;
@end
