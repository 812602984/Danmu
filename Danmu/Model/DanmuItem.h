//
//  DanmuItem.h
//  Danmu
//
//  Created by mac on 2017/5/5.
//  Copyright © 2017年 shaowu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanmuItem : NSObject

/**
 * 弹幕文字
 */
@property (nonatomic, copy) NSString *text;

+ (DanmuItem *)itemWithText:(NSString *)text;

@end
