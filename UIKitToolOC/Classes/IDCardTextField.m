//
//  IDCardTextField.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/9/13.
//

#import "IDCardTextField.h"

#import "KeyboardIDCardView.h"

@interface IDCardTextField ()<UITextInputDelegate,UITextFieldDelegate>

@property (nonatomic, strong) KeyboardIDCardView *keyboard;

@end

@implementation IDCardTextField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configKeyboard];
    }
    
    return self;
}

- (void)setIdCard:(NSString *)idCard{
    _idCard = idCard;
    if (_idCard && _idCard.length > 0) {
        self.text = _idCard;
        self.keyboard.idCard = _idCard;
        self.keyboard.cursorLocation = (int)_idCard.length;
        [self configSelectedText:_idCard CursorLocation:(int)_idCard.length];

    }
}

- (void)configKeyboard{
    self.delegate = self;
    self.inputDelegate = self;
    self.inputView = self.keyboard;
    __weak typeof(self) weakSelf = self;
    
    self.keyboard.idcardBlock = ^(NSString * _Nonnull idcard, int cursorLocation, BOOL inputLimit, BOOL isValid) {
        weakSelf.text = idcard;
        [weakSelf configSelectedText:idcard CursorLocation:cursorLocation];
        if (weakSelf.idcardBlock) {
            weakSelf.idcardBlock(idcard, inputLimit, isValid);
        }
    };
}

- (void)configSelectedText:(NSString *)selecttext
            CursorLocation:(int)cursorLocation{
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:cursorLocation];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:cursorLocation];
    // 创建一个UITextRange
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

- (void)selectionWillChange:(id<UITextInput>)textInput{
    
}

- (void)selectionDidChange:(id<UITextInput>)textInput{
    const NSInteger location = [self offsetFromPosition:textInput.beginningOfDocument toPosition:textInput.selectedTextRange.start];
    self.keyboard.cursorLocation = (int)location;
}

- (void)textDidChange:(nullable id<UITextInput>)textInput {
    
}

- (void)textWillChange:(nullable id<UITextInput>)textInput {
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return  false;
}

- (KeyboardIDCardView *)keyboard{
    if (!_keyboard) {
        _keyboard = [[KeyboardIDCardView alloc] init];
        _keyboard.cursorLocation = 0;
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"KeyboardImage" ofType:@"bundle"];
        NSString *imgPath= [bundlePath stringByAppendingPathComponent:@"KeyboardDeleteImage.png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
        _keyboard.deleteImage = image;
    }
    
    return _keyboard;
}

@end
