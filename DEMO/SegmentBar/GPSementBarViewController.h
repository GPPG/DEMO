//
//  GPSementBarViewController.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/1.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSegmentBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPSementBarViewController : UIViewController

@property (nonatomic, weak) GPSegmentBarView *segmentBarView;


- (void)setUpWithItems: (NSArray <NSString *>*)items childVCs: (NSArray <UIViewController *>*)childVCs;


@end

NS_ASSUME_NONNULL_END
