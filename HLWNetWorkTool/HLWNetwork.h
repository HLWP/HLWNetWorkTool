//
//  HLWNetwork.h
//  HLWNetWorkTool
//
//  Created by siweisoft on 18/3/23.
//  Copyright © 2018年 葫芦娃. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//接口请求成功的回调
typedef void(^HLWResponseSuccess)(id responseObject);
//接口请求失败的回调
typedef void(^HLWResponseFail)(NSError * error);

@interface HLWNetwork : NSObject

+ (HLWNetwork *)sharedNetwork;

/**
 get方法

 @param URLString url
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(HLWResponseSuccess)success
                 failure:(HLWResponseFail)failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(HLWResponseSuccess)success
                  failure:(HLWResponseFail)failure;

/**
 上传数据或图片 支持单张/多张

 @param url url
 @param type type=1 传图片 =2传文件
 @param parameters 参数
 @param dataOrImageArray data数组或图片数组(单张或多张Image数组)
 @param success 成功回调
 @param fail 失败回调
 */
- (void)postDataOrImageUrl:(NSString *)url
               type:(NSString *)type
         parameters:(NSDictionary *)parameters
              dataOrImageArray:(NSArray *)dataOrImageArray
            success:(HLWResponseSuccess)success
               fail:(HLWResponseFail)fail;

@end
