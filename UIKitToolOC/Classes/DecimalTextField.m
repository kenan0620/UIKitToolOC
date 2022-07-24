//
//  DecimalTextField.m
//  UIKitToolOC
//
//  Created by zsn on 2022/7/24.
//

#import "DecimalTextField.h"

@interface DecimalTextField ()<UITextFieldDelegate>

@end

@implementation DecimalTextField

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.maxValue = 999999.99;
        self.maxLength = 6;
        self.maxDecimalLength = 3;
    }
    return self;
}

- (void)setMaxValue:(NSInteger)maxValue{
    _maxValue = maxValue;
}

- (void)setMaxLength:(NSInteger)maxLength{
    _maxLength = maxLength;
}

- (void)setMaxDecimalLength:(NSInteger)maxDecimalLength{
    _maxDecimalLength = maxDecimalLength;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *toStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toStr.length > 0) {
        NSString *lengthRegularStr = [NSString stringWithFormat:@"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,%ld}(([.]\\d{0,5})?)))?",self.maxLength];
        NSPredicate *maxLengthMoney = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lengthRegularStr];
        BOOL flag = [maxLengthMoney evaluateWithObject:toStr];
        
        if (!flag){
            if ([self.decimalDelegate respondsToSelector:@selector(decimalTF_ForbidWithType:)]) {
                [self.decimalDelegate decimalTF_ForbidWithType:(ForbidType_Length)];
            }
            return NO;
        }
        
        NSString *decimalLengthRegularStr = [NSString stringWithFormat:@"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,100}(([.]\\d{0,%ld})?)))?",self.maxDecimalLength];
        NSPredicate *decimalLengthMoney = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalLengthRegularStr];
        flag = [decimalLengthMoney evaluateWithObject:toStr];
        
        if (!flag){
            if ([self.decimalDelegate respondsToSelector:@selector(decimalTF_ForbidWithType:)]) {
                [self.decimalDelegate decimalTF_ForbidWithType:(ForbidType_DecimalLength)];
            }
            return NO;
        }
    }
    if([toStr integerValue] > self.maxValue){
        if ([self.decimalDelegate respondsToSelector:@selector(decimalTF_ForbidWithType:)]) {
            [self.decimalDelegate decimalTF_ForbidWithType:(ForbidType_Value)];
        }
        return NO;
    }
    return YES;
}

@end
