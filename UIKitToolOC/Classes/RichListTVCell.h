//
//  RichListTVCell.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/10/20.
//

#import <UIKit/UIKit.h>

@class AttrModel;

NS_ASSUME_NONNULL_BEGIN

@interface RichListTVCell : UITableViewCell
@property (nonatomic, strong) AttrModel *model;

@end

NS_ASSUME_NONNULL_END
