//
//  ViewController.m
//  TableViewEmbedWebviewDemo
//
//  Created by huangyibiao on 16/2/29.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "HYBTestCell.h"
#import "HYBTestModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) UIWebView      *webView;
@property (nonatomic, strong) UITableView    *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:tableView];
  tableView.allowsSelection = NO;
  
  for (NSUInteger i =0;  i < 10; i++) {
    HYBTestModel *model = [[HYBTestModel alloc] init];
    NSString *html = @"<div id=\"site-info\" style=\"margin: auto;clear: both;text-align: center\"> \
    <a href=\"http://www.henishuo.com\">Copyright 2015 标哥的技术博客</a>\
    &nbsp;|&nbsp;&nbsp;<a href=\"https://github.com/CoderJackyHuang\">标哥的GITHUB</a>\
    &nbsp;|&nbsp;&nbsp;<a href=\"http://www.henishuo.com\">文章总阅读量：140,199 次</a>\
    &nbsp;|&nbsp;&nbsp;<a href=\"http://www.henishuo.com\">文章总数：164 篇</a>\
    &nbsp;|&nbsp;&nbsp;<a href=\"http://www.henishuo.com\">评论总数：448 条</a>\
    </div>";
    model.html = html;
    model.title = @"标哥的技术博客出品，欢迎关注标哥的技术博客http://www.henishuo.com。本demo是学习如何在UITableViewCell中使用UIWebView及如何适应UIWebView的高度";
    
    [self.datasource addObject:model];
  }
  self.tableView = tableView;
  
  _tableView.delegate = self;
  _tableView.dataSource = self;
}

- (NSMutableArray *)datasource {
  if (_datasource == nil) {
    _datasource = [[NSMutableArray alloc] init];
  }
  
  return _datasource;
}

- (UIWebView *)webView {
  if (_webView == nil) {
    _webView = [[UIWebView alloc] init];
    CGSize size = CGSizeMake(self.view.frame.size.width - 20, 0);
    _webView.frame = CGRectMake(0, 0, size.width, size.height);
  }
  
  return _webView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
  
  if (!cell) {
    cell = [[HYBTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
  }
  
  HYBTestModel *model = [self.datasource objectAtIndex:indexPath.row];
  
  [cell configCellWithModel:model];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBTestModel *model = [self.datasource objectAtIndex:indexPath.row];
  CGFloat w = [UIScreen mainScreen].bounds.size.width;
  CGFloat h = [model.title sizeWithFont:[UIFont systemFontOfSize:16]
                      constrainedToSize:CGSizeMake(w, CGFLOAT_MAX)
                          lineBreakMode:NSLineBreakByWordWrapping].height;
  h += 10 + 20;
  
  if (model.webHeight <= 0) {
    // 注意不能使用双引号
    NSString *js = [NSString stringWithFormat:@"document.body.innerHTML = '%@'", model.html];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
    
    NSLog(@"%@", [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
    
    NSString *heightJs = @"document.getElementsByTagName('div')[0].scrollHeight";
    CGFloat webHeight = [[self.webView stringByEvaluatingJavaScriptFromString:heightJs] floatValue];
    NSLog(@"%f", webHeight);

    self.webView.scrollView.contentSize = CGSizeMake(w - 20, webHeight);
    model.webHeight = webHeight + 40;
  }
  
  return h + model.webHeight + 40;
}

@end
