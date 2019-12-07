//
//  ViewController.m
//  ResponderChain
//
//  Created by gtzhou on 2019/11/28.
//  Copyright © 2019 xyz. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "View1.h"
#import "View2.h"
#import "CustomButton.h"
#import "ViewController+TestLoad.h"
#import "EventProxy.h"
#import "ResponderChainDefine.h"
#import "NSObject+Invocation.h"
#import "UIResponder+Router.h"
#import "TesyViewController.h"

@interface ViewController ()

@property(nonatomic,strong) NSDictionary *eventStrategy;
@property(nonatomic,strong) EventProxy *eventProxy;


@end

@implementation ViewController

+ (void)load {
    NSLog(@"ViewController load");
    [self TestLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    
 

    
    View1 *v1 = View1.new;
    v1.frame = CGRectMake(10, 10, 80, 30);
    v1.backgroundColor = UIColor.redColor;
//    [self.view addSubview:v1];
    
    View2 *v2 = View2.new;
    v2.frame = CGRectMake(10, 10, 80, 30);
    v2.backgroundColor = UIColor.blueColor;
//    [self.view addSubview:v2];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(30, 220, 120, 120);
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.blackColor;
    [btn1 addTarget:self action:@selector(action1:) forControlEvents:UIControlEventTouchUpInside];
//    [btn1 setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [self.view addSubview:btn1];
    [btn1 addSubview:v1];

    CustomButton *btn2 = [CustomButton buttonWithType:UIButtonTypeCustom];
    
    btn2.frame = CGRectMake(30, 400, 120, 120);
    [btn2 setTitle:@"btn2" forState:UIControlStateNormal];
    btn2.backgroundColor = UIColor.greenColor;
    
    [btn2 addTarget:self action:@selector(action2:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addSubview:v2];
//    [btn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [self.view addSubview:btn2];
    
}


-(void)action1:(id) respo {
    NSLog(@"resp %@",respo);
    [self routerEventWithName:kTableViewCellEventTappedLeftButton userInfo:@{@"index":@1}];
}

-(void)action2:(id) respo {
    NSLog(@"resp %@",respo);
    [self routerEventWithName:kTableViewCellEventTappedMiddleButton userInfo:@{@"index":@2}];
    TesyViewController *vc = TesyViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    //获取后可以另外添加更多值
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [dict setObject:self forKey:@"vc"];
    [self.eventProxy handleEvent:eventName userInfo:dict.copy];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}



#pragma mark - getter & setter

- (EventProxy *)eventProxy {
    if (!_eventProxy) {
        _eventProxy = EventProxy.new;
    }
    return _eventProxy;
}

- (NSDictionary <NSString *, NSInvocation *>*)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
            kTableViewCellEventTappedLeftButton:[self createInvocationWithSelector:@selector(cellLeftButtonClick:)],
            kTableViewCellEventTappedMiddleButton:[self createInvocationWithSelector:@selector(cellMiddleButtonClick:)],
            kTableViewCellEventTappedRightButton:[self createInvocationWithSelector:@selector(cellRightButtonClick:)]
        };
    }
    return _eventStrategy;
}

@end
