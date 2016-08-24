//
//  HYBTestView.m
//  TableViewEmbedWebviewDemo
//
//  Created by huangyibiao on 16/2/29.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBTestCell.h"

@interface HYBTestCell() <UIWebViewDelegate>



@end

@implementation HYBTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, w - 20, 0)];
    self.label.textColor = [UIColor redColor];
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.numberOfLines = 0;
    [self.contentView addSubview:self.label];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.layer.borderWidth = 2;
      self.webView.delegate = self;
    self.webView.layer.borderColor = [UIColor greenColor].CGColor;
    [self.contentView addSubview:self.webView];
  }
  
  return self;
}

- (void)configCellWithModel:(HYBTestModel *)model {
  self.label.text = model.title;
  [self.label sizeToFit];
  
  NSString *js = [NSString stringWithFormat:@"document.body.innerHTML = '%@'", model.html];
 [self.webView stringByEvaluatingJavaScriptFromString:js];
    //禁止滚动
    self.webView.scrollView.bounces = NO;
    //禁止webView文字选中效果
    self.webView.userInteractionEnabled = NO;
    
  self.webView.frame = CGRectMake(10,
                                  self.label.frame.origin.y + self.label.frame.size.height + 20,
                                  self.label.frame.size.width,
                                  model.webHeight);
}

//IOS UIWebView怎么禁用掉长按后的文字选择框
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //加此代码
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}//这里没效果

@end
