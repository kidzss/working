//
//  ShopModuleServiceProtocol.h
//  BeeHive
//
//  Created by gtzhou on 2019/12/22.
//  Copyright © 2019 一渡. All rights reserved.
//

#ifndef ShopModuleServiceProtocol_h
#define ShopModuleServiceProtocol_h

#import <Foundation/Foundation.h>
#import "BHServiceProtocol.h"

@protocol ShopModuleServiceProtocol <NSObject,BHServiceProtocol>

- (UIViewController *)nativeFetchDetailViewController:(NSDictionary *)params;
- (id)nativePresentImage:(NSDictionary *)params;
- (id)showAlert:(NSDictionary *)params;
// 容错
- (id)nativeNoImage:(NSDictionary *)params;

@end

#endif /* ShopModuleServiceProtocol_h */
