//
//  XLScrollLabelView.m
//  跑马灯Demo
//
//  Created by xiaoliuTX on 2017/4/24.
//  Copyright © 2017年 xiaoliuTX. All rights reserved.
//

#import "XLScrollLabelView.h"
#define SCreenWidth [UIScreen mainScreen].bounds.size.width

typedef NS_ENUM(NSInteger, ScrollingState) {
    ScrollingStateNotBegin = 0,
    ScrollingStateScrolling = 1,
    ScrollingStateStoped = 2
};

@interface XLScrollLabelView() <CAAnimationDelegate>
@property (nonatomic, strong) UIView  *containerView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, assign) CGSize  stringRect;
@property (nonatomic, assign) ScrollingState scrollStatus;
@end

@implementation XLScrollLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        [self setDefaultUI];
    }
    
    return self;
}

- (void)setContentTitle:(NSString *)contentTitle {
    _contentTitle = contentTitle;
    // duration时间大小为5 lenth/s
    self.duration = contentTitle.length / 5;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize size = CGSizeMake(2000, CGRectGetHeight(self.bounds));
    self.stringRect = [self.contentTitle boundingRectWithSize:size
                                                      options:\
                               NSStringDrawingTruncatesLastVisibleLine |
                               NSStringDrawingUsesLineFragmentOrigin |
                               NSStringDrawingUsesFontLeading
                                                   attributes:attribute
                                                      context:nil].size;
    
    if (self.stringRect.width < SCreenWidth - self.padding) {
        self.leftLabel.font = [UIFont systemFontOfSize:14];
        CGRect bounds = self.leftLabel.bounds;
        bounds.size = self.stringRect;
        self.leftLabel.bounds = bounds;
        self.leftLabel.center = CGPointMake(SCreenWidth/2, CGRectGetMidY(self.frame));
        self.leftLabel.text = self.contentTitle;
        self.leftLabel.backgroundColor = [UIColor clearColor];
        self.leftLabel.textColor = [UIColor redColor];
        self.leftLabel.contentMode = UIViewContentModeLeft;
        
        [self addSubview:self.leftLabel];
    } else {
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self addSubview:self.containerView];
        
        self.leftLabel.font = [UIFont systemFontOfSize:14];
        self.leftLabel.backgroundColor = self.backgroundColor;
        self.leftLabel.textColor = self.fontColor;
        self.leftLabel.contentMode = UIViewContentModeLeft;
        self.leftLabel.text = self.contentTitle;
        self.leftLabel.frame = CGRectMake(self.padding, 0, self.stringRect.width, CGRectGetHeight(self.containerView.frame));
        [self.containerView addSubview:self.leftLabel];
        
        self.rightLabel.font = [UIFont systemFontOfSize:14];
        self.rightLabel.backgroundColor = self.backgroundColor;
        self.rightLabel.textColor = self.fontColor;
        self.rightLabel.contentMode = UIViewContentModeLeft;
        self.rightLabel.text = self.contentTitle;
        self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame)+self.spacing, 0, self.stringRect.width, CGRectGetHeight(self.containerView.frame));
        [self.containerView addSubview:self.rightLabel];
    }
}

- (void)startScrolling {
    CABasicAnimation *scrollAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    scrollAnimation.delegate = self;
    scrollAnimation.duration = self.duration;
    scrollAnimation.fromValue = [NSValue valueWithCGPoint:self.containerView.layer.position];
    scrollAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.containerView.layer.position.x - (self.stringRect.width+self.spacing), self.containerView.layer.position.y)];
    scrollAnimation.repeatCount = HUGE_VALF;
    scrollAnimation.autoreverses = NO;
    scrollAnimation.fillMode = kCAFillModeForwards;
    scrollAnimation.removedOnCompletion = NO;
    
    [self.containerView.layer addAnimation:scrollAnimation forKey:@"xiaoliuTX"];
    self.scrollStatus = ScrollingStateScrolling;
}

- (void)pauseScrolling {
    // 暂停动画
    if (self.scrollStatus == ScrollingStateScrolling) {
        CFTimeInterval pausedTime = [self.containerView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.containerView.layer.speed               = 0.0;
        self.containerView.layer.timeOffset          = pausedTime;
        
        self.scrollStatus = ScrollingStateStoped;
    }
}

- (void)consumeScrolling {
    if (self.scrollStatus == ScrollingStateStoped) {
        CFTimeInterval pausedTime     = [self.containerView.layer timeOffset];
        self.containerView.layer.speed                   = 1.0;
        self.containerView.layer.timeOffset              = 0.0;
        self.containerView.layer.beginTime               = 0.0;
        CFTimeInterval timeSincePause = [self.containerView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.containerView.layer.beginTime               = timeSincePause;
        
        self.scrollStatus = ScrollingStateScrolling;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%@ stop is %d",anim,flag);
    self.scrollStatus = ScrollingStateStoped;
    
    [self.containerView.layer removeAnimationForKey:@"xiaoliuTX"];
}

- (void)ScrollDidEnd {
    
}

- (void)setDefaultUI {
    self.fontColor = [UIColor blackColor];
    self.backgroundColor = [UIColor clearColor];
    self.titleFont = [UIFont systemFontOfSize:14];
    self.padding = 20;
    self.spacing = 40;
}

- (void)setFontColor:(UIColor *)fontColor {
    _fontColor = fontColor;
    
    self.leftLabel.textColor = _fontColor;
    self.rightLabel.textColor = _fontColor;
}

-(UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.font = _titleFont;
    }
    
    return _leftLabel;
}

-(UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.font = _titleFont;
    }
    
    return _rightLabel;
}


@end
