//
//  RichListView.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/10/20.
//

#import <UIKit/UIKit.h>

@class AttrModel;

NS_ASSUME_NONNULL_BEGIN

@interface RichListView : UIView
@property (nonatomic, copy) NSArray <AttrModel *> *model;
/// 响应Block
@property (nonatomic, copy) void(^eventBlock)(NSString *key);

@end

NS_ASSUME_NONNULL_END
