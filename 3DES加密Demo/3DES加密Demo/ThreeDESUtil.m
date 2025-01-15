//
//  ThreeDESUtil.m
//  3DES加密Demo
//
//  Created by 陈会超 on 2025/1/14.
//

#import "ThreeDESUtil.h"

@implementation ThreeDESUtil


// 3DES 加密方法的实现
+ (NSString *)encryptData:(NSString *)plainStr withKey:(NSString *)keyStr {
    NSData *plainData = [plainStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char ivBytes[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF}; // 初始化向量，这里使用字节数组表示
    NSData *ivData = [NSData dataWithBytes:ivBytes length:sizeof(ivBytes)];
    
    size_t bufferSize = plainData.length + kCCBlockSize3DES;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 使用 CCCrypt 函数进行 3DES 加密操作，包含 IV
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                    kCCAlgorithm3DES,
                                    kCCOptionPKCS7Padding,
                                    keyData.bytes,
                                    keyData.length,
                                    ivData.bytes,
                                    plainData.bytes,
                                    plainData.length,
                                    buffer,
                                    bufferSize,
                                    &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *encryptedData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSString *encryptedStr = [self dataTohexString:encryptedData ];
        return encryptedStr;
    } else {
        free(buffer);
        return nil;
    }
}

// 3DES 解密方法的实现
+ (NSString *)decryptData:(NSString *)encryptedStr withKey:(NSString *)keyStr {
    NSData *encryptedData = [self hexStringToData:encryptedStr];
    NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char ivBytes[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF}; // 初始化向量，这里使用字节数组表示
    NSData *ivData = [NSData dataWithBytes:ivBytes length:sizeof(ivBytes)];
    
    size_t bufferSize = encryptedData.length + kCCBlockSize3DES;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    size_t numBytesDecrypted = 0;
    
    // 使用 CCCrypt 函数进行 3DES 解密操作，包含 IV
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                    kCCAlgorithm3DES,
                                    kCCOptionPKCS7Padding,
                                    keyData.bytes,
                                    keyData.length,
                                    ivData.bytes,
                                    encryptedData.bytes,
                                    encryptedData.length,
                                    buffer,
                                    bufferSize,
                                    &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *decryptedData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
        
        NSString *decryptedText = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
        
        
        
        
        return decryptedText;
    } else {
        free(buffer);
        return nil;
    }
}

+ (NSString *) dataTohexString:(NSData*)data {
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr = @"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];//16进制数
        if([newHexStr length]==1)
            hexStr = [NSString  stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    
    return hexStr;
}

+ (NSData*)hexStringToData:(NSString*)hexString {
    //NSString *hexString = @"3e435fab9c34891f"; //16进制字符串
    int j=0;
    Byte bytes[hexString.length];  ///3ds key的Byte 数组， 128位
    for(int i=0;i<[hexString length];i++) {
        int int_ch;  /// 两位16进制数转化后的10进制数
        unichar hex_char1 = [hexString characterAtIndex:i]; //两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;//    0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16;//  A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16;//  a 的Ascll - 97
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48);//  0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55;//  A 的Ascll - 65
        else
            int_ch2 = hex_char2-87;//  a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        //NSLog(@"int_ch=%x",int_ch);
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    //    NSData *newData = [[NSData alloc] initWithBytes:bytes length:j];
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:j];
    //NSLog(@"newData=%@",newData);
    return newData;
}

@end
