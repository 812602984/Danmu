//
//  DanmuView.h
//  Danmu
//
//  Created by mac on 2017/5/5.
//  Copyright © 2017年 shaowu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DanmuItem;

@interface DanmuView : UIView

@property (nonatomic) NSUInteger numberOfLines;


- (void)addDanmu:(DanmuItem *)item;


@end
