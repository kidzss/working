//
//  ViewController.m
//  MultiThread
//
//  Created by gtzhou on 2020/1/1.
//  Copyright © 2020 xyz. All rights reserved.
//

#import "ViewController.h"
#import "Opertion/OpertionThread.h"
#import "Opertion/MyOperation.h"

@interface ViewController ()

@property(nonatomic,strong)MyOperation *myOperation;
@property(nonatomic,strong)NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    OpertionThread *opthread = OpertionThread.new;
//    [opthread description];
    
    [self.queue addOperation:self.myOperation];
    
    NSLog(@"load MyOperation Cancel:%d Executing:%d Finished:%d QueueOperationCount:%ld", self.myOperation.isCancelled, self.myOperation.isExecuting, self.myOperation.isFinished, self.queue.operationCount);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"will MyOperation Cancel:%d Executing:%d Finished:%d QueueOperationCount:%ld", self.myOperation.isCancelled, self.myOperation.isExecuting, self.myOperation.isFinished, self.queue.operationCount);
}

- (void)viewDidAppear:(BOOL)animated {
    [self.myOperation cancel];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"did MyOperation Cancel:%d Executing:%d Finished:%d QueueOperationCount:%ld", self.myOperation.isCancelled, self.myOperation.isExecuting, self.myOperation.isFinished, self.queue.operationCount);
    });
}

- (MyOperation *)myOperation{
    if (!_myOperation) {
        _myOperation = [[MyOperation alloc] init];
    }
    return _myOperation;
}

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:1];
    }
    return _queue;
}

@end
