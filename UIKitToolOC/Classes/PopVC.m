//
//  PopVC.m
//  UIKitToolOC
//
//  Created by zsn on 2022/7/24.
//

#import "PopVC.h"

#import "PopConfig.h"

#import <Masonry/Masonry.h>
#import <CategoryToolOC/UIView+Category.h>

@interface PopVC()
@property (nonatomic ,strong) UIView *popBgView;
@property (nonatomic ,strong) UIView *popContentView;
@property (nonatomic ,assign) PopType popType;
@end

@implementation PopVC

//MARK: -----------------------Init-----------------------
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.popBgView];
        [self.popBgView addSubview:self.popContentView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setUpView:self.popType];
    if (self.popContentView) {
        [self.popContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.popBgView);
        }];
    }
}

+ (instancetype)presentView:(UIView *)popView
                    PopType:(PopType)popType{
    PopVC *popVC = [[PopVC alloc] init];
    popVC.popType = popType;
    
    UIWindow *kwindow = [[[UIApplication sharedApplication] delegate] window];
    popVC.frame = kwindow.bounds;
    popVC.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [kwindow addSubview:popVC];
    //设置内容
    popVC.popContentView = popView;
    //设置约束
    [popVC setUpView:popType];
    //执行动画
    [popVC startAnimat:popType];
    return popVC;
}

//MARK: -----------------------KeyBoard 管理-----------------------

- (void) keyBoardWillShow{
    [UIView animateWithDuration:0.2 animations:^{
        self.popBgView.y = [[UIScreen mainScreen] bounds].size.height - self.popBgView.bounds.size.height - [[UIScreen mainScreen] bounds].size.width / 375 * 240;
    } completion:^(BOOL finished) {
    }];
}

- (void) keyBoardWillClose{
    [UIView animateWithDuration:0.2 animations:^{
        self.popBgView.y = [[UIScreen mainScreen] bounds].size.height - self.popBgView.height;
    } completion:^(BOOL finished) {
    }];
}

//MARK: -----------------------弹框动画开始-----------------------
- (void)startAnimat:(PopType)popType{
    [self layoutIfNeeded];
    CGFloat time = [PopConfig sharedConfig].animationTime;
    if (self.popType == PopType_Top) {
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor = [PopConfig sharedConfig].bgColor;
            self.popBgView.top = 0;
            [self layoutIfNeeded];//强制绘制 才能执行masonry动画
        } completion:^(BOOL finished) {
        }];
    }else if (self.popType == PopType_Center){
        self.popBgView.alpha = 0;
        self.popBgView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor =  [PopConfig sharedConfig].bgColor;
            self.popBgView.alpha = 1.0;
            self.popBgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }else if (self.popType == PopType_Bottom){
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor =  [PopConfig sharedConfig].bgColor;
            [self.popBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottom).offset(-self.popBgView.bounds.size.height);
            }];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }else if (self.popType == PopType_Left){
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor =  [PopConfig sharedConfig].bgColor;
            self.popBgView.left = 0;

            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }else if (self.popType == PopType_Right){
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor =  [PopConfig sharedConfig].bgColor;
            [self.popBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset([PopConfig sharedConfig].popSpace);
                make.right.equalTo(self);
            }];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }
}

//MARK: -----------------------弹框动画关闭-----------------------
- (void) closeAnimation:(PopType)popType{
    CGFloat time = [PopConfig sharedConfig].animationTime;
    if (self.popType == PopType_Top) {
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            self.popBgView.top = -self.popBgView.bounds.size.height;
                [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if (self.popType == PopType_Center){
        self.popBgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            self.popBgView.alpha = 0.0;
            self.popBgView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if (self.popType == PopType_Bottom){
        //底部 移除建瓯盘监听
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            self.popBgView.top = self.popBgView.superview.height;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if (self.popType == PopType_Left){
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            self.popBgView.right = 0;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if (self.popType == PopType_Right){
        [UIView animateWithDuration:time animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            self.popBgView.left = self.popBgView.bounds.size.width + [PopConfig sharedConfig].popSpace;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

//MARK: -----------------------弹框视图布局修改-----------------------
- (void) setUpView : (PopType)popType{
    //设置
    if (popType == PopType_Top) {
        //上
        [self.popBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_top);
        }];
        self.popBgView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
        self.popBgView.layer.cornerRadius = [PopConfig sharedConfig].cornerRadius;
        self.popBgView.layer.masksToBounds = true;
    }else if (popType == PopType_Center){
        //中
        [self.popBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-[PopConfig sharedConfig].popCenterSpace);
            make.left.equalTo(self).offset([PopConfig sharedConfig].popCenterSpace);
            make.center.equalTo(self);
        }];
        self.popBgView.layer.masksToBounds = true;
        self.popBgView.layer.cornerRadius = [PopConfig sharedConfig].cornerRadius;
        self.popBgView.layer.masksToBounds = YES;
    }else if (popType == PopType_Bottom){
        //底
        [self.popBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_bottom);
        }];
        self.popBgView.layer.masksToBounds = true;
        self.popBgView.layer.maskedCorners = kCALayerMinXMinYCorner|kCALayerMaxXMinYCorner;
        self.popBgView.layer.cornerRadius = [PopConfig sharedConfig].cornerRadius;
    }else if (popType == PopType_Left){
        //左
        [self.popBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self.mas_left);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - [PopConfig sharedConfig].popSpace);
        }];
        
    }else if (popType == PopType_Right){
        //右
        [self.popBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_right);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - [PopConfig sharedConfig].popSpace);
        }];
    }
    
    
}
//MARK: -----------------------Set-----------------------
- (void)dismiss{
    [self closeAnimation:(PopType_Bottom)];
}
- (void)setShowType:(PopType)popType{
    //如果在底部 防止键盘遮挡需要监听键盘
    if (popType == PopType_Bottom) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillClose) name:UIKeyboardWillHideNotification object:nil];
    }
    _popType = popType;
    [self layoutIfNeeded];
}

- (void)setPopContentView:(UIView *)popContentView{
    _popContentView = popContentView;
    [self.popBgView addSubview:_popContentView];
    [self layoutIfNeeded];
}

//MARK: -----------------------UILazy-----------------------
- (UIView *)popBgView{
    if (!_popBgView) {
        _popBgView = [[UIView alloc] init];
        _popBgView.backgroundColor = [PopConfig sharedConfig].popBgViewColor;
    }
    return _popBgView;
}

@end
