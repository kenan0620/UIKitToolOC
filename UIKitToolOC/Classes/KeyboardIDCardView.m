//
//  KeyboardIDCardView.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/9/13.
//

#import "KeyboardIDCardView.h"

#import <CategoryToolOC/UIImage+Color.h>

@interface KeyboardIDCardView ()
/// 删除按钮
@property (nonatomic, strong) UIButton *deleteBtn;
/// 数据
@property (nonatomic, strong) NSMutableArray *value;
@end

@implementation KeyboardIDCardView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 247 + [UIApplication sharedApplication].windows[0].safeAreaInsets.bottom)];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:216/255.0 green:218/255.0 blue:221/255.0 alpha:1];
        [self configUI];
        self.value = [NSMutableArray arrayWithCapacity:18];
    }
    
    return self;
}

- (void)setKeyBoardBgColor:(UIColor *)keyBoardBgColor{
    _keyBoardBgColor = keyBoardBgColor;
    self.backgroundColor = _keyBoardBgColor;
}

- (void)setIdCard:(NSString *)idCard{
    _idCard = idCard;
    for (int i = 0; i < _idCard.length; i ++) {
        [self.value addObject:[NSString stringWithFormat:@"%@",[_idCard substringWithRange:NSMakeRange(i, 1)]]];
    }
}

- (void)configUI{
    int itemWidth = ([UIScreen mainScreen].bounds.size.width - 4 * 6) / 3;
    for (int i = 0; i < 11; i ++) {
        NSString *showStr = [NSString stringWithFormat:@"%d",i + 1];
        if (i == 9) {
            showStr = @"X";
        }else if (i == 10) {
            showStr = @"0";
        }
        int row = i / 3, column = i % 3;
        
        UIButton *itemBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        itemBtn.frame = CGRectMake(((column % 3) * (itemWidth + 6)) + 6, (row * (46 + 6)) + 6, itemWidth, 46);
        [itemBtn setTitle:showStr forState:(UIControlStateNormal)];
        [itemBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [itemBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        [itemBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.00]] forState:(UIControlStateHighlighted)];

        itemBtn.titleLabel.font = [UIFont systemFontOfSize:24 weight:(UIFontWeightMedium)];
        itemBtn.tag = i;
        // Shadow Code
        itemBtn.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.40].CGColor;
        itemBtn.layer.shadowOffset = CGSizeMake(0,1);
        itemBtn.layer.shadowRadius = 1;
        itemBtn.layer.shadowOpacity = 1;
        itemBtn.backgroundColor = [UIColor whiteColor];
        itemBtn.layer.cornerRadius = 5;
        itemBtn.layer.masksToBounds = true;
        [itemBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:itemBtn];
    }
    [self addSubview:self.deleteBtn];
    self.deleteBtn.frame = CGRectMake((2 * (itemWidth + 6)) + 6, (3 * (46 + 6)) + 6, itemWidth, 46);
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
}

//MARK: -----------------------Setter-----------------------
- (void)setCursorLocation:(int)cursorLocation{
    _cursorLocation = cursorLocation;
}

- (void)setDeleteImage:(UIImage *)deleteImage{
    _deleteImage = deleteImage;
    [self.deleteBtn setImage:_deleteImage forState:(UIControlStateNormal)];
}

- (void)setDeleteText:(NSString *)deleteText{
    _deleteText = deleteText;
    [self.deleteBtn setTitle:_deleteText forState:(UIControlStateNormal)];
}

- (void)setDeleteTextColor:(UIColor *)deleteTextColor{
    _deleteTextColor = deleteTextColor;
    [self.deleteBtn setTitleColor:_deleteTextColor forState:(UIControlStateNormal)];
}

//MARK: -----------------------Event-----------------------
- (void)itemBtnClick:(UIButton *)sender{
    if (self.value.count == 18) {
        self.idcardBlock([[self.value.copy componentsJoinedByString:@","] stringByReplacingOccurrencesOfString:@"," withString:@""],
                         self.cursorLocation,
                         true,
                         false);
        return;
    }
    if (sender.tag == 9) {
        if (self.value.count == 17) {
            [self.value insertObject:@"X" atIndex:self.cursorLocation];
        }else{
            return;
        }
    }else if (sender.tag == 10) {
        [self.value insertObject:@"0" atIndex:self.cursorLocation];
    }else {
        [self.value insertObject:[NSString stringWithFormat:@"%ld",sender.tag + 1] atIndex:self.cursorLocation];
    }
    self.cursorLocation += 1;
    bool isValid = false;
    if (self.value.count == 18) {
        NSArray *calculateList = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2, @0];
        NSArray *checkList = @[@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",];
        int sum = 0;
        for (int i = 0; i < self.value.count - 1; i ++) {
            sum += [self.value[i] intValue] * [calculateList[i] intValue];
        }
        int checkIndex = sum % 11;
        isValid = [checkList[checkIndex] isEqualToString:[NSString stringWithFormat:@"%d",[self.value.lastObject intValue]]];
    }
    if (self.idcardBlock) {
        self.idcardBlock([[self.value.copy componentsJoinedByString:@","] stringByReplacingOccurrencesOfString:@"," withString:@""],
                         self.cursorLocation,
                         false,
                         isValid);
    }
}

- (void)deleteBtnClick{
    if (self.value.count != 0 && self.cursorLocation > 0) {
        self.cursorLocation -= 1;
        [self.value removeObjectAtIndex:self.cursorLocation];
    }
    if (self.idcardBlock) {
        self.idcardBlock([[self.value.copy componentsJoinedByString:@","] stringByReplacingOccurrencesOfString:@"," withString:@""],
                         self.cursorLocation,
                         false,
                         false);
    }
}

//MARK: -----------------------UILazy-----------------------
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    
    return _deleteBtn;
}


@end
