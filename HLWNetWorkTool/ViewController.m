//
//  ViewController.m
//  HLWNetWorkTool
//
//  Created by siweisoft on 18/3/23.
//  Copyright © 2018年 葫芦娃. All rights reserved.
//

#import "ViewController.h"
#import "HLWNetwork.h"
#import "HLWUtilsMacros.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage * image = [UIImage imageNamed:@"index.jpeg"];
    UIImage * image2 = [UIImage imageNamed:@"123.jpeg"];
    UIImage * image3 = [UIImage imageNamed:@"111"];
//    NSString * path=[[NSBundle mainBundle] pathForResource:@"罗马假日CD2" ofType:@"rmvb"];
//    NSData * data = [NSData dataWithContentsOfFile:path];
    /**
     上传数据或图片 支持单张/多张
     
     @param url url
     @param type type=1 传图片 =2传文件
     @param parameters 参数
     @param dataOrImageArray data数组或图片数组(单张或多张Image数组)
     @param success 成功回调
     @param fail 失败回调
     */
    [[HLWNetwork sharedNetwork] postDataOrImageUrl:@"" type:@"1" parameters:nil dataOrImageArray:@[image,image2,image3] success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } fail:^(NSError *error) {
        
    }];
}

-(void)update:(NSNotification *)notification{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
