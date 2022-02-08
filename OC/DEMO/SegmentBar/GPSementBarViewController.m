//
//  GPSementBarViewController.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/1.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPSementBarViewController.h"
#import "UIView+GPLayout.h"


@interface GPSementBarViewController ()<GPSegmentBarDelegate, UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation GPSementBarViewController

- (GPSegmentBarView *)segmentBarView {
    if (!_segmentBarView) {
        GPSegmentBarView *segmentBarView = [GPSegmentBarView segmentBarWithFrame:CGRectZero];
        segmentBarView.delegate = self;
        segmentBarView.backgroundColor = [UIColor brownColor];
        [self.view addSubview:segmentBarView];
        _segmentBarView = segmentBarView;
        
    }
    return _segmentBarView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)setUpWithItems: (NSArray <NSString *>*)items childVCs: (NSArray <UIViewController *>*)childVCs {
    
    
    NSAssert(items.count != 0 || items.count == childVCs.count, @"个数不一致, 请自己检查");
    
    self.segmentBarView.items = items;
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    // 添加几个自控制器
    // 在contentView, 展示子控制器的视图内容
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    
    //
    self.contentView.contentSize = CGSizeMake(items.count * self.view.frame.size.width, 0);
    
    self.segmentBarView.selectIndex = 0;
    
    
    
}


- (void)showChildVCViewsAtIndex: (NSInteger)index {
    
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:vc.view];
    
    // 滚动到对应的位置
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.width, 0) animated:YES];
    
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (self.segmentBarView.superview == self.view) {
        self.segmentBarView.frame = CGRectMake(0, 60, self.view.width, 35);
        
        CGFloat contentViewY = self.segmentBarView.y + self.segmentBarView.height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height - contentViewY);
        self.contentView.frame = contentFrame;
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);

        return;
    }
    
    
    CGRect contentFrame = CGRectMake(0, 0,self.view.width,self.view.height);
    self.contentView.frame = contentFrame;
     self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    
    // 其他的控制器视图, 大小
    // 遍历所有的视图, 重新添加, 重新进行布局
    // 注意: 1个视图
    //
    
    self.segmentBarView.selectIndex = self.segmentBarView.selectIndex;
    
}

#pragma mark - 选项卡代理方法
- (void)segmentBar:(GPSegmentBarView *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"%zd----%zd", fromIndex, toIndex);
    [self showChildVCViewsAtIndex:toIndex];
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算最后的索引
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    
    //    [self showChildVCViewsAtIndex:index];
    self.segmentBarView.selectIndex = index;
    
}

@end
