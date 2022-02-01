//
//  GPSegmentBarView.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/1.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSegmenBarConfig.h"

NS_ASSUME_NONNULL_BEGIN


@class GPSegmentBarView;
@protocol GPSegmentBarDelegate <NSObject>

/**
 代理方法, 告诉外界, 内部的点击数据

 @param segmentBar segmentBar
 @param toIndex    选中的索引(从0开始)
 @param fromIndex  上一个索引
 */
- (void)segmentBar: (GPSegmentBarView *)segmentBar didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end


@interface GPSegmentBarView : UIView

/**
 快速创建一个选项卡控件

 @param frame frame

 @return 选项卡控件
 */
+ (instancetype)segmentBarWithFrame: (CGRect)frame;
/** 代理 */
@property (nonatomic, weak) id<GPSegmentBarDelegate> delegate;
/** 数据源 */
@property (nonatomic, strong) NSArray <NSString *>*items;
/** 当前选中的索引, 双向设置 */
@property (nonatomic, assign) NSInteger selectIndex;

- (void)updateWithConfig: (void(^)(GPSegmenBarConfig *config))configBlock;



@end

NS_ASSUME_NONNULL_END
