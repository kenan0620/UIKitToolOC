//
//  TextSwitch.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/9/14.
//

#import "TextSwitch.h"

#define ThumbTintWidth 24.0f
#define AnimatedTime 0.3

@interface TextSwitch ()
/// 开关容器
@property (nonatomic, strong) UIView *containerView;
/// 开内容视图
@property (nonatomic, strong) UIView *onContentView;
/// 关内容视图
@property (nonatomic, strong) UIView *offContentView;
/// 圆形部位
@property (nonatomic, strong) UIView *thumbTintView;
/// 开文本视图
@property (nonatomic, strong) UILabel *onLabel;
/// 关文本视图
@property (nonatomic, strong) UILabel *offLabel;
/// 边框
@property (nonatomic, strong) UIView *borderView;

@end

@implementation TextSwitch

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:[self roundRect:frame]];
    if (self) {
        [self config];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (void)setBounds:(CGRect)bounds{
    [super setBounds:[self roundRect:bounds]];
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:[self roundRect:frame]];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.containerView.frame = self.bounds;
    
    CGFloat itemWidth = CGRectGetWidth(self.containerView.bounds);
    CGFloat itemHeight = CGRectGetHeight(self.containerView.bounds);
    
    self.containerView.backgroundColor = [UIColor redColor];
    CGFloat cornerRadius = itemHeight / 2.0;
    self.containerView.layer.cornerRadius = cornerRadius;
    self.containerView.layer.masksToBounds = YES;
    
    CGFloat margin = (itemHeight - ThumbTintWidth) / 2.0;
    
    self.borderView.frame = self.bounds;
    self.borderView.layer.borderWidth = 1.0;
    self.borderView.layer.cornerRadius = cornerRadius;
    self.borderView.layer.masksToBounds = YES;
    
    if (!self.isOn) {// frame of off status
        self.onContentView.frame = CGRectMake(- itemWidth,0,itemWidth,itemHeight);
        self.offContentView.frame = CGRectMake(0,0,itemWidth,itemHeight);
        self.thumbTintView.frame = CGRectMake(margin,margin, ThumbTintWidth,ThumbTintWidth);
    } else {// frame of on status
        self.onContentView.frame = CGRectMake(0,0, itemWidth,itemHeight);
        self.offContentView.frame = CGRectMake(itemWidth,0, itemWidth, itemHeight);
        self.thumbTintView.frame = CGRectMake(itemWidth - margin - ThumbTintWidth, margin, ThumbTintWidth, ThumbTintWidth);
    }
    
    CGFloat labelHeight = 20.0f;
    CGFloat labelMargin = cornerRadius - (sqrtf(powf(cornerRadius, 2) - powf(labelHeight / 2.0, 2))) + margin;
    
    self.onLabel.frame = CGRectMake(labelMargin,
                                    cornerRadius - labelHeight / 2.0,
                                    itemWidth - labelMargin - ThumbTintWidth - 2 * margin,
                                    labelHeight);
    
    self.offLabel.frame = CGRectMake(ThumbTintWidth + 2 * margin,
                                     cornerRadius - labelHeight / 2.0,
                                     itemWidth - labelMargin - ThumbTintWidth - 2 * margin,
                                     labelHeight);
}

#pragma mark - Private API

- (void)config{
    self.backgroundColor = [UIColor clearColor];
    
    _style = SwitchStyleNoBorder;
    
    _onTintColor = [UIColor colorWithRed:0/255.0 green:102/255.0 blue:255/255.0 alpha:1.0];
    _onTextColor = [UIColor whiteColor];
    _tintColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    _offTextColor = _onTextColor;
    _thumbTintColor = [UIColor whiteColor];
    _textFont = [UIFont systemFontOfSize:14];
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    _containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_containerView];
    
    _borderView = [[UIView alloc] initWithFrame:CGRectZero];
    _borderView.userInteractionEnabled = NO;
    _borderView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.2];
    _borderView.layer.borderColor = _on ? _onTintColor.CGColor : _tintColor.CGColor;
    _borderView.hidden = (_style == SwitchStyleNoBorder) ? YES : NO;
    [_containerView addSubview:_borderView];
    
    _onContentView = [[UIView alloc] initWithFrame:self.bounds];
    _onContentView.backgroundColor = (_style == SwitchStyleNoBorder) ? _onTintColor : [UIColor clearColor];
    [_containerView addSubview:_onContentView];
    
    _offContentView = [[UIView alloc] initWithFrame:self.bounds];
    _offContentView.backgroundColor = (_style == SwitchStyleNoBorder) ? _tintColor : [UIColor clearColor];
    [_containerView addSubview:_offContentView];
    
    _onLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _onLabel.backgroundColor = [UIColor clearColor];
    _onLabel.textAlignment = NSTextAlignmentLeft;
    _onLabel.textColor = _onTextColor;
    _onLabel.font = _textFont;
    _onLabel.text = _onText;
    [_onContentView addSubview:_onLabel];
    
    _offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _offLabel.backgroundColor = [UIColor clearColor];
    _offLabel.textAlignment = NSTextAlignmentRight;
    _offLabel.textColor = _offTextColor;
    _offLabel.font = _textFont;
    _offLabel.text = _offText;
    [_offContentView addSubview:_offLabel];
    
    _thumbTintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ThumbTintWidth, ThumbTintWidth)];
    _thumbTintView.backgroundColor = (_style == SwitchStyleNoBorder) ? _thumbTintColor : (_on ? _onTintColor : _tintColor);
    _thumbTintView.layer.cornerRadius = ThumbTintWidth / 2.0;
    [_containerView addSubview:_thumbTintView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTapTapGestureRecognizerEvent:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePanGestureRecognizerEvent:)];
    [self addGestureRecognizer:panGesture];
}

- (CGRect)roundRect:(CGRect)frameOrBounds{
    CGRect viewRect = frameOrBounds;
    
    //    if (viewRect.size.height > SwitchMaxHeight) {
    //        viewRect.size.height = SwitchMaxHeight;
    //    }
    //
    //    if (viewRect.size.height < SwitchMinHeight) {
    //        viewRect.size.height = SwitchMinHeight;
    //    }
    
    //    if (viewRect.size.width < SwitchMinWidth) {
    //        viewRect.size.width = SwitchMinWidth;
    //    }
    
    return viewRect;
}

- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.isOn animated:YES];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)recognizer{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            [self scaleThumbTintViewFrame:YES];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            [self scaleThumbTintViewFrame:NO];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            break;
        }
        case UIGestureRecognizerStateEnded:
            [self setOn:!self.isOn animated:YES];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}

- (void)scaleThumbTintViewFrame:(BOOL)scale{
    CGFloat margin = (CGRectGetHeight(self.bounds) - ThumbTintWidth) / 2.0;
    CGFloat offset = 6.0f;
    
    CGRect preFrame = self.thumbTintView.frame;
    
    if (self.isOn) {
        self.thumbTintView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - ThumbTintWidth - margin - (scale ? offset : 0),
                                              margin,
                                              ThumbTintWidth + (scale ? offset : 0),
                                              ThumbTintWidth);
    } else {
        self.thumbTintView.frame = CGRectMake(margin,
                                              margin,
                                              ThumbTintWidth + (scale ? offset : 0),
                                              ThumbTintWidth);
    }
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"bounds"];
    [animation1 setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(preFrame), CGRectGetHeight(preFrame))]];
    [animation1 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.thumbTintView.frame), CGRectGetHeight(self.thumbTintView.frame))]];
    [animation1 setDuration:0.3];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.thumbTintView.layer addAnimation:animation1 forKey:NULL];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation2 setFromValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(preFrame), CGRectGetMidY(preFrame))]];
    [animation2 setToValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.thumbTintView.frame), CGRectGetMidY(self.thumbTintView.frame))]];
    [animation2 setDuration:0.3];
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.thumbTintView.layer addAnimation:animation2 forKey:NULL];
}


//MARK: -----------------------Setter-----------------------
- (void)setStyle:(SwitchStyle)style{
    if (_style != style) {
        _style = style;
        if (_style == SwitchStyleNoBorder) {
            _onContentView.backgroundColor = _onTintColor;
            _onLabel.textColor = _onTextColor;
            _offLabel.textColor = _offTextColor;
            _offContentView.backgroundColor = _tintColor;
            
            _thumbTintView.backgroundColor = _thumbTintColor;

            _borderView.hidden = YES;
            _borderView.layer.borderColor = _on ? _onTintColor.CGColor : _tintColor.CGColor;
        } else {
            _onContentView.backgroundColor = [UIColor clearColor];
            _onLabel.textColor = _onTintColor;
            _offLabel.textColor = _tintColor;
            _offContentView.backgroundColor = [UIColor clearColor];
            
            _thumbTintView.backgroundColor = _on ? _onTintColor : _tintColor;

            _borderView.hidden = NO;
            _borderView.layer.borderColor = _on ? _onTintColor.CGColor : _tintColor.CGColor;
        }
        
        [self setNeedsLayout];
    }
}

- (void)setOnTintColor:(UIColor *)onTintColor{
    if (_onTintColor != onTintColor) {
        _onTintColor = onTintColor;
        if (_style == SwitchStyleNoBorder) {
            _onContentView.backgroundColor = _onTintColor;
        } else {
            if (_on) {
                _borderView.layer.borderColor = _onTintColor.CGColor;
                _thumbTintView.backgroundColor = _onTintColor;
            }
            
            _onLabel.textColor = _onTintColor;
        }
    }
}

- (void)setOnTextColor:(UIColor *)onTextColor{
    if (_onTextColor != onTextColor) {
        _onTextColor = onTextColor;
        if (_style == SwitchStyleNoBorder) {
            _onLabel.textColor = onTextColor;
        }
    }
}

- (void)setOnText:(NSString *)onText{
    if (_onText != onText) {
        _onText = onText;
        _onLabel.text = onText;
    }
}

- (void)setTintColor:(UIColor *)tintColor{
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
        
        if (_style == SwitchStyleNoBorder) {
            _offContentView.backgroundColor = tintColor;
        } else {
            if (!_on) {
                _borderView.layer.borderColor = _tintColor.CGColor;
                _thumbTintView.backgroundColor = _tintColor;
            }
            _offLabel.textColor = _tintColor;
        }
    }
}

- (void)setOffTextColor:(UIColor *)offTextColor{
    if (_offTextColor != offTextColor) {
        _offTextColor = offTextColor;
        
        if (_style == SwitchStyleNoBorder) {
            _offLabel.textColor = _offTextColor;
        }
    }
}

- (void)setOffText:(NSString *)offText{
    if (_offText != offText) {
        _offText = offText;
        _offLabel.text = offText;
    }
}

- (void)setTextFont:(UIFont *)textFont{
    if(_textFont != textFont){
        _onLabel.font = _textFont;
        _offLabel.font = _textFont;
    }
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor{
    if (_thumbTintColor != thumbTintColor) {
        _thumbTintColor = thumbTintColor;
        if (_style == SwitchStyleNoBorder) {
            _thumbTintView.backgroundColor = _thumbTintColor;
        }
    }
}

- (void)setOn:(BOOL)on{
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated{
    if (_on == on) {
        return;
    }
    
    _on = on;
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - ThumbTintWidth) / 2.0;
    
    CGRect onFrame = self.onContentView.frame;
    CGRect offFrame = self.offContentView.frame;
    CGRect knobFrame = self.thumbTintView.frame;
    
    if (!self.isOn) {
        // frame of off status
        self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.thumbTintView.frame = CGRectMake(margin,
                                         margin,
                                         ThumbTintWidth,
                                         ThumbTintWidth);
        
        if (_style == SwitchStyleBorder) {
            self.borderView.layer.borderColor = _tintColor.CGColor;
            
            self.thumbTintView.backgroundColor = _tintColor;
        }
    } else {
        // frame of on status
        self.onContentView.frame = CGRectMake(0,
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds),
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.thumbTintView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - ThumbTintWidth,
                                         margin,
                                         ThumbTintWidth,
                                         ThumbTintWidth);
        
        if (_style == SwitchStyleBorder) {
            self.borderView.layer.borderColor = _onTintColor.CGColor;
            
            self.thumbTintView.backgroundColor = _onTintColor;
        }
    }
    
    if (animated) {
        // on
        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"bounds"];
        [animation1 setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(onFrame), CGRectGetHeight(onFrame))]];
        [animation1 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.onContentView.frame), CGRectGetHeight(self.onContentView.frame))]];
        [animation1 setDuration:AnimatedTime];
        [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.onContentView.layer addAnimation:animation1 forKey:NULL];
        
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation2 setFromValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(onFrame), CGRectGetMidY(onFrame))]];
        [animation2 setToValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.onContentView.frame), CGRectGetMidY(self.onContentView.frame))]];
        [animation2 setDuration:AnimatedTime];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.onContentView.layer addAnimation:animation2 forKey:NULL];
        
        // off
        CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"bounds"];
        [animation3 setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(offFrame), CGRectGetHeight(offFrame))]];
        [animation3 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.offContentView.frame), CGRectGetHeight(self.offContentView.frame))]];
        [animation3 setDuration:AnimatedTime];
        [animation3 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.offContentView.layer addAnimation:animation3 forKey:NULL];
        
        CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation4 setFromValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(offFrame), CGRectGetMidY(offFrame))]];
        [animation4 setToValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.offContentView.frame), CGRectGetMidY(self.offContentView.frame))]];
        [animation4 setDuration:AnimatedTime];
        [animation4 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.offContentView.layer addAnimation:animation4 forKey:NULL];
        
        // knob
        CABasicAnimation *animation5 = [CABasicAnimation animationWithKeyPath:@"bounds"];
        [animation5 setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(knobFrame), CGRectGetHeight(knobFrame))]];
        [animation5 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.thumbTintView.frame), CGRectGetHeight(self.thumbTintView.frame))]];
        [animation5 setDuration:AnimatedTime];
        [animation5 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.thumbTintView.layer addAnimation:animation5 forKey:NULL];
        
        CABasicAnimation *animation6 = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation6 setFromValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(knobFrame), CGRectGetMidY(knobFrame))]];
        [animation6 setToValue:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.thumbTintView.frame), CGRectGetMidY(self.thumbTintView.frame))]];
        [animation6 setDuration:AnimatedTime];
        [animation6 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.thumbTintView.layer addAnimation:animation6 forKey:NULL];
    }
}
@end

