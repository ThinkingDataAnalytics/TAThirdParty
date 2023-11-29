//
//  ViewController.m
//  ThirdParty
//
//  Created by Charles on 9.1.23.
//

#import "ViewController.h"
#import <ThinkingSDK/ThinkingSDK.h>
#import <Firebase/Firebase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadFirebaseBtns];
}

#pragma mark -  Firebase Analytics

- (void)loadFirebaseBtns {
    NSArray *array = @[
        @"configure",
        @"enableThirdPartySharing",
        @"logEventWithName",
        @"setUserPropertyString",
        @"setUserID",
        @"setDefaultEventParameters",
        @"resetAnalyticsData"
    ];
    
    for (int i=0; i<array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(100, 100+(i*70), 200, 50)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:UIColor.redColor];
        [btn addTarget:self action:NSSelectorFromString([NSString stringWithFormat:@"btnOnClick_%@:", array[i]]) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateHighlighted];
        [self.view addSubview:btn];
    }
}

- (void)btnOnClick_configure:(id)sender {
    [FIRApp configure];
}

- (void)btnOnClick_enableThirdPartySharing:(id)sender {
    [TDAnalytics enableThirdPartySharing:TDThirdPartyTypeFirebase];    
}

- (void)btnOnClick_logEventWithName:(id)sender {
    [FIRAnalytics logEventWithName:@"td_event" parameters:@{ @"product_name" : @"firebase-analytics" }];
}

- (void)btnOnClick_setUserPropertyString:(id)sender {
    [FIRAnalytics setUserPropertyString:@"Tiki" forName:@"td_user_name"];
}

- (void)btnOnClick_setUserID:(id)sender {
    [FIRAnalytics setUserID:@"imars"];
}

- (void)btnOnClick_setDefaultEventParameters:(id)sender {
    [FIRAnalytics setDefaultEventParameters:@{@"default_key":@"defeult_value"}];
}

- (void)btnOnClick_resetAnalyticsData:(id)sender {
    [FIRAnalytics resetAnalyticsData];
}


@end
