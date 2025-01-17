//
//  AppDelegate.m
//  3DES加密Demo
//
//  Created by 陈会超 on 2025/1/14.
//

#import "AppDelegate.h"
#import "ThreeDESUtil.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *plainText = @"123456";
    NSString *keyString = @"b8cd52d822f60b182db3319b8effa977"; // 密钥，长度应为 16 或 24 字节，这里仅为示例
    
    // 加密
    NSString *dualStr1 = [ThreeDESUtil encryptData:plainText withKey:keyString];
    //解密
    NSString *dualStr2 = [ThreeDESUtil decryptData:dualStr1 withKey:keyString];
    
    NSLog(@"加密后的字符串是：%@\n解密后的字符串是：%@",dualStr1,dualStr2);
    
    return YES;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
