//
//  View1.m
//  ResponderChain
//
//  Created by gtzhou on 2019/11/28.
//  Copyright © 2019 xyz. All rights reserved.
//

#import "View1.h"
#import "UIResponder+Router.h"
#import "ResponderChainDefine.h"

@implementation View1

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"startPoint x = %lf y = %lf",point.x,point.y);
    [self routerEventWithName:kTableViewCellEventTappedLeftButton userInfo:@{@"index":@1}];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    NSLog(@"movePoint x = %lf y = %lf",point.x,point.y);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    NSLog(@"endPoint x = %lf y = %lf",point.x,point.y);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
