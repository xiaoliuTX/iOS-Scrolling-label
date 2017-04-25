//
//  ViewController.m
//  跑马灯Demo
//
//  Created by xiaoliuTX on 2017/4/24.
//  Copyright © 2017年 xiaoliuTX. All rights reserved.
//

#import "ViewController.h"
#import "XLScrollLabelView.h"

@interface ViewController () <CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *notiveView;
@property (nonatomic, strong) NSString *noticeTitleStr;
@property (nonatomic, assign) NSInteger padding;      //与屏幕左右边缘的距离
@property (nonatomic, assign) NSInteger spacing;      //相邻两个控件间的距离
@property (nonatomic, strong) UIView *contentView;    //实际内容视图
@property (nonatomic, assign) CGSize rectSize;

@property (nonatomic, strong) XLScrollLabelView *scrollLableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollLableView = [[XLScrollLabelView alloc] initWithFrame:self.notiveView.bounds];
    self.scrollLableView.contentTitle = @" 中共中央政治局4月25日召开会议，分析研究当前经济形势和经济工作。";
    [self.notiveView addSubview:self.scrollLableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (IBAction)start:(id)sender {
    [self.scrollLableView startScrolling];
}

- (IBAction)stop:(id)sender {
    [self.scrollLableView pauseScrolling];
}

- (IBAction)consume:(id)sender {
    [self.scrollLableView consumeScrolling];
}

@end
