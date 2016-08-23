//
//  HYBTestView.m
//  TableViewEmbedWebviewDemo
//
//  Created by huangyibiao on 16/2/29.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBTestCell.h"

@interface HYBTestCell() <UIWebViewDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIWebView *webView;

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
  
  self.webView.frame = CGRectMake(10,
                                  self.label.frame.origin.y + self.label.frame.size.height + 20,
                                  self.label.frame.size.width,
                                  model.webHeight);
}

@end
