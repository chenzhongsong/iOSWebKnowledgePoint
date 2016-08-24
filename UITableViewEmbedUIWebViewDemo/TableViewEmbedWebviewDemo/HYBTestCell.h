//
//  HYBTestView.h
//  TableViewEmbedWebviewDemo
//
//  Created by huangyibiao on 16/2/29.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBTestModel.h"

@interface HYBTestCell : UITableViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIWebView *webView;

- (void)configCellWithModel:(HYBTestModel *)model;

@end
