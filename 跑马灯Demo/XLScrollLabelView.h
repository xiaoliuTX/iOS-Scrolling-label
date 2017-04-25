//
//  XLScrollLabelView.h
//  跑马灯Demo
//
//  Created by xiaoliuTX on 2017/4/24.
//  Copyright © 2017年 xiaoliuTX. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCreenWidth [UIScreen mainScreen].bounds.size.width

@interface XLScrollLabelView : UIView
@property (nonatomic, strong) NSString *contentTitle;
@property (nonatomic, strong) UIColor  *fontColor;
@property (nonatomic, strong) UIColor  *backGroundColor;
@property (nonatomic, strong) UIFont   *titleFont;
@property (nonatomic, assign) NSInteger padding;      //与屏幕左右边缘的距离
@property (nonatomic, assign) NSInteger spacing;
@property (nonatomic, assign) NSInteger duration;
- (void)startScrolling;
- (void)pauseScrolling;
- (void)consumeScrolling;
@end
