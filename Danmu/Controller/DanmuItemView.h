//
//  DanmuItemView.h
//  Danmu
//
//  Created by mac on 2017/5/5.
//  Copyright © 2017年 shaowu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DanmuItem;
@class DanmuItemView;

@protocol DanmuItemViewDelegate <NSObject>

@optional
- (void)danmuItemViewWillRemoveFromSuperView:(DanmuItemView *)view;

@end

@interface DanmuItemView : UIView <CAAnimationDelegate>

@property (nonatomic, weak) id<DanmuItemViewDelegate> delegate;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) DanmuItem *item;

@property (nonatomic) CGFloat height;   //default is 30.


- (void)prepareForReuse;

@end
