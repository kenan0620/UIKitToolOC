//
//  AttrModel.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttrModel : NSObject
/// 键
@property (nonatomic, copy) NSMutableAttributedString *key;
/// 值
@property (nonatomic, copy) NSMutableAttributedString *value;
/// 是否展示分割线
@property (nonatomic, assign) bool isShowLine;
/// 响应键值
@property (nonatomic, copy) NSString *eventKey;
/// 是否展示更新分割线位置
@property (nonatomic, assign) bool isUpdateLineSpace;
/// 分割线位置
@property (nonatomic, assign) CGFloat lineSpace;
/// 高度
@property (nonatomic, assign) CGFloat height;
/// 控件与Cell间距
@property (nonatomic, assign) CGFloat margin;
/// 标题宽度
@property (nonatomic, assign) CGFloat titleWidth;
/// 内容换行对齐方式
@property (nonatomic, assign) NSTextAlignment valueTextAlignment;

@end

NS_ASSUME_NONNULL_END
