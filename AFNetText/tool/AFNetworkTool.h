//
//  AFNetworkTool.h
//  AFNetText
//
//  Created by wxxu on 15/1/27.
//  Copyright (c) 2015年 wxxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AFNetworkTool : NSObject

/**第一种，利用AFJSONRequestOperation**/
+ (void)jsonRequestWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;
+ (void)jsonRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success fail:(void (^)())fail;

/**第二种方法，利用AFHTTPRequestOperation**/
+ (void)httpRequestWithUrl:(NSString *)url success:(void (^)(NSData *data))success fail:(void (^)())fail;
+ (void)httpRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSData *data))success fail:(void (^)())fail;

/**通过URL获取图片**/
+ (void)imageRequestWithUrl:(NSString *)url success:(void (^)(UIImage *image))success fail:(void (^)())fail;

/**URL获取plist文件**/
+ (void)plistRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *plist))success fail:(void (^)())fail;
+ (void)plistRequestWithUrl:(NSString *)url success:(void (^)(NSDictionary *plist))success fail:(void (^)())fail;

/**URL获取XML数据**/
+ (void)xmlRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSXMLParser *xmlParser))success fail:(void (^)())fail;
+ (void)xmlRequestWithUrl:(NSString *)url success:(void (^)(NSXMLParser *xmlParser))success fail:(void (^)())fail;
@end
