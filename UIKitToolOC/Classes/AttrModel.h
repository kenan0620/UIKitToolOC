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
@end

NS_ASSUME_NONNULL_END
