//
//  MyOperation.m
//  MultiThread
//
//  Created by gtzhou on 2020/1/1.
//  Copyright © 2020 xyz. All rights reserved.
//  并发的NSOperation自定义子类

/*关于并发的NSOperation自定义子类就比较复杂了，但可以提供更高的可定制性，
 这也是为什么SDWebImage使用自定义子类来实现下载任务。

实现并发的自定义子类需要重写以下几个方法或属性:

start方法:
 任务加入到队列后，队列会管理任务并在线程被调度后适时调用start方法，
 start方法就是我们编写的任务，需要注意的是，不论怎样都不允许调用父类的start方法

isExecuting:
 任务是否正在执行，需要手动调用KVO方法来进行通知，这样，其他类如果监听了任务的该属性就可以获取到通知

 isFinished:
 任务是否结束，需要手动调用KVO方法来进行通知，队列也需要监听该属性的值，用于判断任务是否结束，
 由于我们编写的任务很可能是异步的，所以start方法返回也不一定代表任务就结束了，
 任务结束需要开发者手动修改该属性的值，队列就可以正常的移除任务
 
isAsynchronous:
 是否并发执行，之前需要使用isConcurrent，但isConcurrent被废弃了，该属性标识是否并发*/

#import "MyOperation.h"

@implementation MyOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (void)start {
    //在任务开始前设置executing为YES，在此之前可能会进行一些初始化操作
    self.executing = YES;
    for (int i = 0; i < 500; i++) {
        /*
        需要在适当的位置判断外部是否调用了cancel方法
        如果被cancel了需要正确的结束任务
        */
        if (self.isCancelled) {
            //任务被取消正确结束前手动设置状态
            self.executing = NO;
            self.finished = YES;
            NSLog(@"executing %d",self.executing);
            return;
        }
        //输出任务的各个状态以及队列的任务数
        NSLog(@"Task %d %@ Cancel:%d Executing:%d Finished:%d QueueOperationCount:%ld", i, [NSThread currentThread], self.cancelled, self.executing, self.finished, [[NSOperationQueue currentQueue] operationCount]);
        [NSThread sleepForTimeInterval:0.1];
    }
    NSLog(@"Task Complete.");
    //任务执行完成后手动设置状态
    self.executing = NO;
    self.finished = YES;
}

- (void)setExecuting:(BOOL)executing {
    //调用KVO通知
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    //调用KVO通知
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isExecuting {
    return _executing;
}

- (void)setFinished:(BOOL)finished {
    //调用KVO通知
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    //调用KVO通知
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isAsynchronous {
    return NO;
}

@end
