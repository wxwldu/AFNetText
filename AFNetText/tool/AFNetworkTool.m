//
//  AFNetworkTool.m
//  AFNetText
//
//  Created by wxxu on 15/1/27.
//  Copyright (c) 2015年 wxxu. All rights reserved.
//

#import "AFNetworkTool.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "AFImageRequestOperation.h"
#import "AFXMLRequestOperation.h"
#import "AFPropertyListRequestOperation.h"
#import "NSURLRequest+Url.h"

@implementation AFNetworkTool
/**
 第一种，利用AFJSONRequestOperation
 param:url          请求地址
 param:params       请求参数
 param:success      请求成返回json
 param:fail         请求失败
 */
+ (void)jsonRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success fail:(void (^)())fail
{
    
    // 创建一个请求对象
    NSURLRequest *request = [NSURLRequest requestWithPath:url params:params];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        if (success) {
            success(JSON);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
        if (fail) {
            fail();
        }
    }];
    
    [op start];
}

+ (void)jsonRequestWithUrl:(NSString *)url success:(void (^)(id))success fail:(void (^)())fail
{
    return [self jsonRequestWithUrl:url params:nil success:success fail:fail];
}

/**
 第二种方法，利用AFHTTPRequestOperation
 param:url          请求地址
 param:params       请求参数
 param:success      请求成返回json
 param:fail         请求失败
 */
+ (void)httpRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSData *data))success fail:(void (^)())fail
{
    NSURL *urlstr = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlstr];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        if (success) {
            success(data);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        if (fail) {
            fail();
        }

    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

+ (void)httpRequestWithUrl:(NSString *)url success:(void (^)(NSData *data))success fail:(void (^)())fail
{
    return [self httpRequestWithUrl:url params:nil success:success fail:fail];
}

/**
 通过URL获取图片
 param:url          请求地址
 param:success      请求成返回json
 param:fail         请求失败
 */
+ (void)imageRequestWithUrl:(NSString *)url success:(void (^)(UIImage *image))success fail:(void (^)())fail
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse*response, UIImage *image) {
        if (success) {
            success(image);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@",error);
        if (fail) {
            fail();
        }

    }];

    [operation start];
}

/**
 URL获取plist文件
 param:url          请求地址
 param:params       请求参数
 param:success      请求成返回json
 param:fail         请求失败
 */
+ (void)plistRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *plist))success fail:(void (^)())fail
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [AFPropertyListRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    AFPropertyListRequestOperation *operation = [AFPropertyListRequestOperation propertyListRequestOperationWithRequest:request success:^(NSURLRequest *request,NSHTTPURLResponse *response, id propertyList) {
        if (success) {
            success(propertyList);
        }
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id propertyList) {
        NSLog(@"%@",error);
        if (fail) {
            fail();
        }

    }];
    
    [operation start];
}

+ (void)plistRequestWithUrl:(NSString *)url  success:(void (^)(NSDictionary *plist))success fail:(void (^)())fail
{
    [self plistRequestWithUrl:url params:nil success:success fail:fail];
}

/**
 URL获取XML数据
 param:url          请求地址
 param:params       请求参数
 param:success      请求成返回json
 param:fail         请求失败
 */
+ (void)xmlRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSXMLParser *xmlParser))success fail:(void (^)())fail
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFXMLRequestOperation *operation =
    [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest*request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        if (success) {
            success(XMLParser);
        }
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser*XMLParser) {
        NSLog(@"%@",error);
        if (fail) {
            fail();
        }
    }];
    [operation start];
}

+ (void)xmlRequestWithUrl:(NSString *)url success:(void (^)(NSXMLParser *xmlParser))success fail:(void (^)())fail
{
    [self xmlRequestWithUrl:url params:nil success:success fail:fail];
}

@end
