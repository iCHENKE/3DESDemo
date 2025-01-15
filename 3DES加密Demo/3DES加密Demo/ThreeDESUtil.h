//
//  ThreeDESUtil.h
//  3DES加密Demo
//
//  Created by 陈会超 on 2025/1/14.
//

#import <CommonCrypto/CommonCrypto.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreeDESUtil : NSObject

// 3DES 加密方法，输入明文数据、密钥数据，输出加密后的数据
+ (NSString *)encryptData:(NSString *)plainStr withKey:(NSString *)keyStr;

// 3DES 解密方法，输入加密数据、密钥数据，输出解密后的数据
+ (NSString *)decryptData:(NSString *)encryptedStr withKey:(NSString *)keyStr;

// Data转16进制
+ (NSString *) dataTohexString:(NSData*)data;

// 16进制转Data
+ (NSData*)hexStringToData:(NSString*)hexString;

@end

NS_ASSUME_NONNULL_END
