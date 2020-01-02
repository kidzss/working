//
//  OpertionThread.m
//  MultiThread
//
//  Created by gtzhou on 2020/1/1.
//  Copyright © 2020 xyz. All rights reserved.
//

#import "OpertionThread.h"
#import "TestOperation.h"

@interface OpertionThread()

@property(nonatomic,strong) NSOperationQueue *opQueue;

@end

@implementation OpertionThread

-(void)infoPrint:(NSString*)str {
    NSLog(@"name = %@,thread=%@,operationqueue=%@ ",str,[NSThread currentThread],[NSOperationQueue currentQueue]);
    //获取队列中的所有任务
//    NSLog(@"%@",[self.opQueue operations]);
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self simple1];
        [self NSBlockOPerationRun];
        TestOperation *operation = [[TestOperation alloc] initWithObject:@"Hello, World!"];
        [operation main];
    }
    return self;
}

- (NSOperationQueue *)opQueue {
    if (!_opQueue) {
        _opQueue = [[NSOperationQueue alloc] init];
        //设置最大并发数
        /*
        队列支持的最大任务并发数
        如果为1，则只支持同时处理一个任务，即串行队列，
        如果为大于1的数，则支持同时处理多个任务，即并发队列，底层使用线程池管理多个线程来执行任务
        */
        [_opQueue setMaxConcurrentOperationCount:2];
    }
    return _opQueue;
}

- (void)simple1 {
    //创建一个NSBlockOperation对象，传入一个block
    //  + (instancetype)blockOperationWithBlock:(void (^)(void))block;//在当前线程执行
    //- (void)addExecutionBlock:(void (^)(void))block;//新开线程执行
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [self infoPrint:@"11"];
    }];
    
    [operation addExecutionBlock:^{
        [self infoPrint:@"22"];
    }];
    
    [operation addExecutionBlock:^{
        [self infoPrint:@"33"];
    }];
    //使用[operation start];
    //除blockOperationWithBlock在主线程操作外，其他block都在其他线程并发执行
    //没有设置队列就是在main queue,但是线程不一定时主线程，即便设置maxConcurrent=1
//    [operation start];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [self infoPrint:@"operation2"];
    }];

    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        [self infoPrint:@"operation3"];
    }];

    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        [self infoPrint:@"operation4"];
    }];
    
    /*
    创建一个NSInvocationOperation对象，指定执行的对象和方法
    该方法可以接收一个参数即object
    */
    //NSInvocationOperation基于应用的一个target对象和selector来创建operation object. 如果你已经有现有的方法来执行需要的任务, 就可以使用这个类
    //该实现方式是同步顺序执行.
    NSInvocationOperation *ioperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(infoPrint:) object:@"iop"];
    
    //使用[ioperation start];
    //该实现方式是同步顺序执行.
//    [ioperation start];
    
    [operation2 addDependency:operation];
    [operation3 addDependency:operation];
    [operation4 addDependency:operation3];
    
    /*
    向队列中添加一组任务
    是否等待任务完成，如果YES，则阻塞当前线程直到所有任务完成
    如果为False，不阻塞当前线程
    */
    [self.opQueue addOperations:@[operation,operation2] waitUntilFinished:YES];
    [self.opQueue addOperation:operation3];
    [self.opQueue addOperation:operation4];
    [self.opQueue addOperation:ioperation];
}

-(void)NSBlockOPerationRun {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self infoPrint:@"opqueue"];
    }];
    
    [self.opQueue addOperation:op];
}

@end
