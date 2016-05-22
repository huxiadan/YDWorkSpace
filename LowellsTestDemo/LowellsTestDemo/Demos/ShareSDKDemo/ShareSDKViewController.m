//
//  ShareSDKViewController.m
//  LowellsTestDemo
//
//  Created by lowell on 4/19/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import "ShareSDKViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"

@interface ShareSDKViewController ()

@end

@implementation ShareSDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
//    UEAPPInstance.spInfo.appKeyWeChat = @"wx6800d409849e4103";
//    UEAPPInstance.spInfo.appSecretWeChat = @"dc8dd5ed2a5e4dec95e4919c82661a0f";
//    
//    UEAPPInstance.spInfo.appKeyQQ = @"1103350839";
//    UEAPPInstance.spInfo.appSecretQQ = @"3Dfz5mXEUcf4dh7z";
//    
//    UEAPPInstance.spInfo.appKeySinaWeiBo = @"3384862860";
//    UEAPPInstance.spInfo.appSecretSinaWeiBo = @"1349d7ae9a22a3fb7263734e75d80313";
//    UEAPPInstance.spInfo.redirectUriSinaWeiBo = @"http://www.uedoctor.com";
//    
//    UEAPPInstance.spInfo.appKeyShareSDK = @"3d89781215c7";
    
    [ShareSDK registerApp:@"3d89781215c7"
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformSubTypeQQFriend),
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"3384862860"
                                                appSecret:@"1349d7ae9a22a3fb7263734e75d80313"
                                              redirectUri:@"http://www.uedoctor.com"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx6800d409849e4103"
                                            appSecret:@"dc8dd5ed2a5e4dec95e4919c82661a0f"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"1103350839"
                                           appKey:@"3Dfz5mXEUcf4dh7z"
                                         authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
          }];
}

- (void)share {
    // 创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"faafadfadsfadfadfadsf"
                                     images:nil
                                        url:nil
                                      title:@"fadfadfadfadfad"
                                       type:SSDKContentTypeAuto];
    //进行分享
    [ShareSDK share:SSDKPlatformSubTypeQQFriend
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         NSLog(@"*************************%@", error);
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                     message:[NSString stringWithFormat:@"%@", error]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             default:
                 break;
         }
     }];
}

@end
