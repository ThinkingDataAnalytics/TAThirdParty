//
//  TAThirdPartyManager.m
//  ThinkingSDK
//
//  Created by wwango on 2022/2/11.
//

#import "TAThirdPartyManager.h"
#import "TAAppsFlyerSyncData.h"
#import "TAIronSourceSyncData.h"
#import "TAAdjustSyncData.h"
#import "TABranchSyncData.h"
#import "TATopOnSyncData.h"
#import "TAReYunSyncData.h"
#import "TATradPlusSyncData.h"
#import "TAKochavaSyncData.h"


 typedef NS_OPTIONS(NSInteger, TAInnerThirdPartyShareType) {
     TAInnerThirdPartyShareTypeNONE               = 0,
     TAInnerThirdPartyShareTypeAPPSFLYER          = 1 << 0,
     TAInnerThirdPartyShareTypeIRONSOURCE         = 1 << 1,
     TAInnerThirdPartyShareTypeADJUST             = 1 << 2,
     TAInnerThirdPartyShareTypeBRANCH             = 1 << 3,
     TAInnerThirdPartyShareTypeTOPON              = 1 << 4,
     TAInnerThirdPartyShareTypeTRACKING           = 1 << 5,
     TAInnerThirdPartyShareTypeTRADPLUS           = 1 << 6,
     TAInnerThirdPartyShareTypeAPPLOVIN           = 1 << 7,
     TAInnerThirdPartyShareTypeKOCHAVA            = 1 << 8,
     TAInnerThirdPartyShareTypeTALKINGDATA        = 1 << 9,
     TAInnerThirdPartyShareTypeFIREBASE           = 1 << 10,
     
 };

static NSMutableDictionary *_thirdPartyManagerMap;

// 注册三方数据采集服务，在APP启动时会从数据区
char * kThinkingServices_service __attribute((used, section("__DATA, ThinkingServices"))) = "{ \"TAThirdPartyProtocol\" : \"TAThirdPartyManager\"}";
@interface TAThirdPartyManager()<TAThirdPartyProtocol>

@end


@implementation TAThirdPartyManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _thirdPartyManagerMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)enableThirdPartySharing:(NSNumber *)type instance:(id<TAThinkingTrackProtocol>)instance
{
    [self enableThirdPartySharing:type instance:instance property:@{}];
}

- (void)enableThirdPartySharing:(NSNumber *)typee instance:(id<TAThinkingTrackProtocol>)instance property:(NSDictionary *)property
{
    NSDictionary *info = [self _getThridInfoWithType:typee];
    
    NSString *libClass = info[@"libClass"];
    NSString *taThirdClass = info[@"taThirdClass"];
    NSString *errorMes = info[@"errorMes"];
    
    if (!NSClassFromString(libClass)) {
        NSLog(@"%@", errorMes);
    }else {
        id<TAThirdPartySyncProtocol> syncData = [_thirdPartyManagerMap objectForKey:taThirdClass];
        if (!syncData) {
            syncData = [NSClassFromString(taThirdClass) new];
            [_thirdPartyManagerMap setObject:syncData forKey:taThirdClass];
        }
        [syncData syncThirdData:instance property:[property copy]];
    }
}




- (NSDictionary *)_getThridInfoWithType:(NSNumber *)typee {
    
    static NSDictionary *_ta_ThridInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ta_ThridInfo = @{
            @(TAInnerThirdPartyShareTypeAPPSFLYER):@{
         
                   @"libClass": @"AppsFlyerLib",
                   @"taThirdClass":@"TAAppsFlyerSyncData",
                   @"errorMes":@"AppsFlyer数据同步异常: 未安装AppsFlyer SDK"
           
            },
            @(TAInnerThirdPartyShareTypeIRONSOURCE):@{
           
                   @"libClass": @"IronSource",
                   @"taThirdClass":@"TAIronSourceSyncData",
                   @"errorMes": @"IronSource数据同步异常: 未安装IronSource SDK"
     
            },
            @(TAInnerThirdPartyShareTypeADJUST):@{
  
                   @"libClass": @"Adjust",
                   @"taThirdClass":@"TAAdjustSyncData",
                   @"errorMes": @"Adjust数据同步异常: 未安装Adjust SDK"
 
            },
            @(TAInnerThirdPartyShareTypeBRANCH):@{
  
                   @"libClass": @"Branch",
                   @"taThirdClass":@"TABranchSyncData",
                   @"errorMes": @"Branch数据同步异常: 未安装Branch SDK"
 
            },
            @(TAInnerThirdPartyShareTypeTOPON):@{
  
                   @"libClass": @"ATAPI",
                   @"taThirdClass":@"TATopOnSyncData",
                   @"errorMes": @"TopOn数据同步异常: 未安装TopOn SDK"
 
            },
            @(TAInnerThirdPartyShareTypeTRACKING):@{
  
                   @"libClass": @"Tracking",
                   @"taThirdClass":@"TAReYunSyncData",
                   @"errorMes": @"热云数据同步异常: 未安装热云 SDK"
 
            },
            @(TAInnerThirdPartyShareTypeTRADPLUS):@{
  
                   @"libClass": @"TradPlus",
                   @"taThirdClass":@"TATradPlusSyncData",
                   @"errorMes": @"TradPlus数据同步异常: 未安装TradPlus SDK"
 
            },
            @(TAInnerThirdPartyShareTypeAPPLOVIN):@{
  
                   @"libClass": @"ALSdk",
                   @"taThirdClass":@"TAAppLovinSyncData",
                   @"errorMes": @"AppLovin数据同步异常: 未安装AppLovin SDK"
 
            },
            @(TAInnerThirdPartyShareTypeKOCHAVA):@{
  
                   @"libClass": @"KVATracker",
                   @"taThirdClass":@"TAKochavaSyncData",
                   @"errorMes": @"Kochava数据同步异常: 未安装Kochava SDK"
 
            },
            @(TAInnerThirdPartyShareTypeFIREBASE):@{
  
                   @"libClass": @"FIRAnalytics",
                   @"taThirdClass":@"TAFirebaseSyncData",
                   @"errorMes": @"FIREBASE数据同步异常: 未安装FIRAnalytics SDK"
 
            },
        };
    });
    
    return _ta_ThridInfo[typee];
    
}


@end
