//
//  GPPictureCycleView.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/2.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPPictureCycleProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoadImageBlock)(UIImageView *imageView, NSURL *url);

@protocol GPPictureCycleViewDelegate <NSObject>

- (void)adPicViewDidSelectedPicModel: (id <GPPictureCycleProtocol>)picM;

@end


@interface GPPictureCycleView : UIView
+ (instancetype)picViewWithLoadImageBlock: (LoadImageBlock)loadBlock;
/**
 *  用于加载图片的代码块, 必须赋值
 */
@property (nonatomic, copy) LoadImageBlock loadBlock;

/**
 *  用于告知外界, 当前滚动到的是哪个广告数据模型
 */
@property (nonatomic, strong) id<GPPictureCycleViewDelegate> delegate;

/**
 *  用来展示图片的数据源
 */
@property (nonatomic, strong) NSArray <id <GPPictureCycleProtocol>>*picModels;



@end

NS_ASSUME_NONNULL_END
