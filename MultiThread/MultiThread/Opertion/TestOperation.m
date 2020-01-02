//
//  TestOperation.m
//  MultiThread
//
//  Created by gtzhou on 2020/1/1.
//  Copyright © 2020 xyz. All rights reserved.
//

#import "TestOperation.h"

@implementation TestOperation

//自定义子类继承了NSOperation并且实现了main方法，在官方文档中指出，非并发任务，
//直接调用main方法即可，调用之后就和调用普通对象的方法一样，使用当前线程来执行main方法
//最好不要只实现一个main方法就交给队列去执行，即使我们没有实现start方法，
//这里调用start方法以后依旧会执行main方法。这个非并发版本不建议写，好像也没有什么场景需要这样写，
//反而更加复杂，如果不小心加入到队列中还会产生未知的错误。

- (instancetype)initWithObject:(id)obj {
    
    if (self = [super init]) {
        self.obj = obj;
    }
    return self;
}

- (void)main {
    @autoreleasepool {
        for (int i = 0; i < 10; i++) {
            NSLog(@"Task %@ %d %@", self.obj, i, [NSThread currentThread]);
        }
        NSLog(@"Task Complete!");
    }

}

@end
