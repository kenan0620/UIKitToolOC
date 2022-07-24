//
//  AdaptTableView.m
//  UIKitToolOC
//
//  Created by zsn on 2022/7/24.
//

#import "AdaptTableView.h"

@implementation AdaptTableView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame style:(UITableViewStylePlain)];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        /// 分割线的样式
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        /// 是否显示滚动条
        self.showsVerticalScrollIndicator = NO;
        /// 估算Header高度
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_MIN)];
        self.estimatedSectionHeaderHeight = 0.0;
        self.sectionHeaderHeight = UITableViewAutomaticDimension;
        /// 估算Footer高度
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_MIN)];
        self.estimatedSectionFooterHeight = 0.0;
        self.sectionFooterHeight = UITableViewAutomaticDimension;
        /// 估算Cell高度
        self.estimatedRowHeight = 10;
        self.rowHeight = UITableViewAutomaticDimension;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 15.0, *)) {
            /// 默认头部高度
            self.sectionHeaderTopPadding = 0;
        }
    }
    
    return self;
}

@end
