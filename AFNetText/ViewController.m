//
//  ViewController.m
//  AFNetText
//
//  Created by wxxu on 15/1/27.
//  Copyright (c) 2015年 wxxu. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkTool.h"

@interface ViewController (){
    UIImageView *imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(buttonAction6:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 150, 150)];
    [self.view addSubview:imageView];
    
}

#pragma mark 利用AFJSONRequestOperation
- (void)buttonAction:(UIButton *)button
{
    NSString *url = @"https://alpha-api.app.net/stream/0/posts/stream/global";
    [AFNetworkTool jsonRequestWithUrl:url params:nil success:^(id json) {
        NSLog(@"%@",json);
    } fail:^{
        NSLog(@"请求失败");
    }];
}

- (void)buttonAction2:(UIButton *)button
{
    NSString *url = @"https://alpha-api.app.net/stream/0/posts/stream/global";
    [AFNetworkTool jsonRequestWithUrl:url success:^(id json) {
        NSLog(@"%@",json);
    } fail:^{
        NSLog(@"请求失败");
    }];
}

#pragma mark 利用AFHTTPRequestOperation
- (void)buttonAction3:(UIButton *)button
{
    NSString *url = @"https://alpha-api.app.net/stream/0/posts/stream/global";
    [AFNetworkTool httpRequestWithUrl:url params:nil success:^(NSData *data) {
        NSError *error;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (!error) {
            NSLog(@"%@",json);
        }
    } fail:^{
        NSLog(@"请求失败");
    }];
}

#pragma mark 通过URL获取图片
- (void)buttonAction4:(UIButton *)button
{
    NSString *url = @"http://www.scott-sherwood.com/wp-content/uploads/2013/01/scene.png";
    [AFNetworkTool imageRequestWithUrl:url success:^(UIImage *image) {
        imageView.image = image;
    } fail:^{
        NSLog(@"请求失败");
    }];
}

#pragma mark URL获取plist文件
- (void)buttonAction5:(UIButton *)button
{
    NSString *url = @"http://www.calinks.com.cn/buick/kls/Buickhousekeeper.plist";
    [AFNetworkTool plistRequestWithUrl:url success:^(NSDictionary *plist) {
        NSArray *values = [plist allValues];
        [values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSLog(@"%lu:%@",(unsigned long)idx,obj);
        }];
    } fail:^{
        NSLog(@"请求失败");
    }];
}

#pragma mark URL获取XML数据
- (void)buttonAction6:(UIButton *)button
{
    NSString *url = @"http://113.106.90.22:5244/sshopinfo";
    [AFNetworkTool xmlRequestWithUrl:url success:^(NSXMLParser *xmlParser) {
        xmlParser.delegate = self;
        [xmlParser setShouldProcessNamespaces:YES];
        [xmlParser parse];
    } fail:^{
        NSLog(@"请求失败");
    }];
}

#pragma mark 解析xml
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"解析开始！");
}
//解析起始标记
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary*)attributeDict{
    NSLog(@"标记：%@",elementName);
    
}
//解析文本节点
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSLog(@"值：%@",string);
}
//解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSLog(@"结束标记：%@",elementName);
}
//文档结束时触发
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"解析结束！");
}
@end
