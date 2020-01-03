//
//  ViewController.m
//  PerformSelector
//
//  Created by 周刚涛 on 2019/12/31.
//  Copyright © 2019 xyz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self func1];//1234
    [self func2];//124
    [self func3];//1234
    [self func4];//1234
    [self func5];//124
    [self func6];
    [self func7];
    [self func8];
}

- (void)test:(NSString*)str {
    NSLog(@"%@:3 - %@",str, [NSThread currentThread]);
}

- (void)func1 {
    NSLog(@"func1 1 - %@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"func1 2 - %@", [NSThread currentThread]);
        [self performSelector:@selector(test:) withObject:@"func1"];
        NSLog(@"func1 4 - %@", [NSThread currentThread]);
    });
}
//输出结果：1，2，3，4
//原因： 因为 performSelector:withObject: 会在当前线程立即执行指定的 selector 方法。

- (void)func2 {
    NSLog(@"func2 1 - %@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSLog(@"func2 2 - %@", [NSThread currentThread]);
        [self performSelector:@selector(test:) withObject:@"func2" afterDelay:0];
        NSLog(@"func2 4 - %@", [NSThread currentThread]);
    });
}
//输出结果：1，2，4
//原因： 因为 performSelector:withObject:afterDelay: 实际是往 RunLoop 里面注册一个定时器，
//而在子线程中，RunLoop 是没有开启（默认）的，所有不会输出 3

- (void)func3 {
    NSLog(@"func3 1 - %@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"func3 2 - %@", [NSThread currentThread]);
        [self performSelector:@selector(test:) withObject:@"func3" afterDelay:0];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"func3 4 - %@", [NSThread currentThread]);
    });
}
//输出结果：1，2，3，4
//原因： 由于 [[NSRunLoop currentRunLoop] run]; 会创建的当前子线程对应的 RunLoop 对象并启动了，
//因此可以执行 test 方法；并且 test 执行完后，RunLoop 中注册的定时器已经无效，所以还可以输出 4

- (void)func4 {
    NSLog(@"func4 1 - %@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"func4 2 - %@", [NSThread currentThread]);
        [self performSelector:@selector(test:) onThread:[NSThread currentThread]
                   withObject:@"func4" waitUntilDone:YES];
        NSLog(@"func4 4 - %@", [NSThread currentThread]);
    });
}
//输出结果：1，2，3，4
//原因： 因为 performSelector:onThread:withObject:waitUntilDone: 会在指定的线程执行，
//而执行的策略根据参数 wait 处理，这里传 YES 表明将会立即阻断 指定的线程 并执行指定的 selector

- (void)func5 {
    NSLog(@"func5 1 - %@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"func5 2 - %@", [NSThread currentThread]);
        [self performSelector:@selector(test:) onThread:[NSThread currentThread]
                   withObject:@"func5" waitUntilDone:NO];
        NSLog(@"func5 4 - %@", [NSThread currentThread]);
    });
}
//输出结果：1，2，4
//原因： 因为 performSelector:onThread:withObject:waitUntilDone: 会在指定的线程执行，
//而执行的策略根据参数 wait 处理，这里传 NO 表明不会立即阻断 指定的线程 而是将 selector
//添加到指定线程的 RunLoop 中等待时机执行。（该例子中，子线程 RunLoop 没有启动，所有没有输出 3）


- (void)func6 {
    NSLog(@"func6 1 - %@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"func6 2 - %@", [NSThread currentThread]);
        [self performSelector:@selector(test:) onThread:[NSThread currentThread]
                   withObject:@"func6" waitUntilDone:NO];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"func6 4 - %@", [NSThread currentThread]);
    });
}
//输出结果：1，2，3
//原因： 由于 [[NSRunLoop currentRunLoop] run]; 已经创建的当前子线程对应的 RunLoop 对象并启动了，
//因此可以执行 test 方法；但是 test 方法执行完后，RunLoop 并没有结束（使用这种启动方式，
//RunLoop 会一直运行下去，在此期间会处理来自输入源的数据，并且会在 NSDefaultRunLoopMode
//模式下重复调用 runMode:beforeDate: 方法）所以无法继续输出 4。

-(void)func7 {
    NSLog(@"func7 1 - %@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"func7 2 - %@", [NSThread currentThread]);
        [self performSelector:@selector(test:)
                     onThread:[NSThread currentThread]
                   withObject:@"func7"
                waitUntilDone:NO];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        NSLog(@"func7 4 - %@", [NSThread currentThread]);
    });
}
//输出结果：1，2，3
//原因： 由于 [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
//已经创建的当前子线程对应的 RunLoop 对象并启动了，因此可以执行 test 方法；但是 test 方法执行完后，RunLoop 并没有结束（使用这种启动方式，可以设置超时时间，在超时时间到达之前，runloop会一直运行，
//在此期间runloop会处理来自输入源的数据，并且会在 NSDefaultRunLoopMode 模式下重复调用
//runMode:beforeDate: 方法）所以无法继续输出 4。

- (void)func8 {
    NSLog(@"func8 1 - %@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"func8 2 - %@", [NSThread currentThread]);
        [self performSelector:@selector(test:)
                     onThread:[NSThread currentThread]
                   withObject:@"func8"
                waitUntilDone:NO];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
        NSLog(@"func8 4 - %@", [NSThread currentThread]);
    });
}

//输出结果：1，2，3，4
//原因： 由于 [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//已经创建的当前子线程对应的 RunLoop 对象并启动了，因此可以执行 test 方法；而且 test 方法执行完后，
//RunLoop 立刻结束（使用这种启动方式 ，RunLoop 会运行一次，超时时间到达或者第一个 input source 被处理，
//则 RunLoop 就会退出）所以可以继续输出 4

@end
