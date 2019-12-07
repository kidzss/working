//
//  TesyViewController.m
//  ResponderChain
//
//  Created by gtzhou on 2019/12/7.
//  Copyright © 2019 xyz. All rights reserved.
//

#import "TesyViewController.h"
#import "YYWeakProxy.h"

@interface TesyViewController ()
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation TesyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"time";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    YYWeakProxy *proxy = [YYWeakProxy proxyWithTarget:self];
    
    NSTimer *one = [NSTimer scheduledTimerWithTimeInterval:1.f target:proxy selector:@selector(tick:) userInfo:nil repeats:YES];
     _timer = one;
//    [self.timer fire];
    
    
//    __weak typeof(self) weakSelf = self;
//
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [weakSelf tick:@""];
//    }];
    
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

-(void)tick:(id) sender {
    NSLog(@"tick");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
