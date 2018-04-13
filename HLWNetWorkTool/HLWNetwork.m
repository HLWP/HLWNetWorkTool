//
//  HLWNetwork.m
//  HLWNetWorkTool
//
//  Created by siweisoft on 18/3/23.
//  Copyright © 2018年 葫芦娃. All rights reserved.
//

#import "HLWNetwork.h"
#import "AFNetworking.h"
#import "NSDictionary+NullWitdDic.h"

@implementation HLWNetwork

+ (HLWNetwork *)sharedNetwork{
    static HLWNetwork * sharedNetwork;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetwork = [[super allocWithZone:NULL] init];
    });
    return sharedNetwork;
}

-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(HLWResponseSuccess)success
                 failure:(HLWResponseFail)failure {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //超时时间设置
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    NSLog(@"%@",URLString);
    NSLog(@"%@",parameters);
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dict = [NSDictionary changeType:responseObject];
        //如果服务器返回格式正确 传递数据  否则提示用户 服务器返回数据格式有误
        if (success && dict) {
            success(dict);
        }else{
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        //http请求的状态码
        NSLog(@"http请求的状态码------%zd",response.statusCode);
        if (failure) {
           failure(error);
           NSLog(@"失败原因--------->:%@",error);
        }
    }];
}

#pragma mark -- POST请求 --
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(HLWResponseSuccess)success
                  failure:(HLWResponseFail)failure {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    NSLog(@"%@",URLString);
    NSLog(@"%@",parameters);
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dict = [NSDictionary changeType:responseObject];
        NSLog(@"%@",dict);
        //如果服务器返回格式正确 传递数据  否则提示用户 服务器返回数据格式有误
        if (success && dict) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //获取http请求
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        //http请求的状态码
        NSLog(@"http请求的状态码------%zd",response.statusCode);
        if (failure) {
            failure(error);
            NSLog(@"失败原因--------->:%@",error);
        }
    }];
}

#pragma mark - 上传图片
- (void)postDataOrImageUrl:(NSString *)url
               type:(NSString *)type
         parameters:(NSDictionary *)parameters
         dataOrImageArray:(NSArray *)dataOrImageArray
            success:(HLWResponseSuccess)success
               fail:(HLWResponseFail)fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //超时时间设置
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain", nil];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        if ([type isEqualToString:@"1"]) {
            for (int i = 0; i < dataOrImageArray.count; i++) {
                UIImage *image = dataOrImageArray[i];
                NSData *data = UIImagePNGRepresentation(image);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                NSString *fileName = [NSString stringWithFormat:@"SW_%@.png",[formatter stringFromDate:[NSDate date]]];
                NSLog(@"fileName----->%@",fileName);
                /*
                 *该方法的参数
                 1. appendPartWithFileData：要上传的照片[二进制流]
                 2. name：对应网站上[upload.php中]处理文件的字段（比如myFile）
                 3. fileName：要保存在服务器上的文件名
                 4. mimeType：上传的文件的类型
                 */
                [formData appendPartWithFileData:data name:@"myFile" fileName:fileName mimeType:@"image/jpg"];
            }
        }else{
            NSData *data = dataOrImageArray[0];
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
            NSString * fileName = [NSString stringWithFormat:@"SW_%@.mp4",[formatter stringFromDate:[NSDate date]]];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如file）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"mp4"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"progress is %@",uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //如果服务器返回格式正确 传递数据  否则提示用户 服务器返回数据格式有误
        if (success && responseObject) {
            success(responseObject);
        }else{
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        //http请求的状态码
        NSLog(@"http请求的状态码------%zd",response.statusCode);
        if (fail) {
            fail(error);
            NSLog(@"失败原因--------->:%@",error);
        }
    }];
}


@end
