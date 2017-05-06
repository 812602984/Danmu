//
//  DanmuItem.m
//  Danmu
//
//  Created by mac on 2017/5/5.
//  Copyright © 2017年 shaowu. All rights reserved.
//

#import "DanmuItem.h"

@implementation DanmuItem

+ (DanmuItem *)itemWithText:(NSString *)text
{
    DanmuItem *item = [DanmuItem new];
    item.text = text;
    return item;
}

@end
