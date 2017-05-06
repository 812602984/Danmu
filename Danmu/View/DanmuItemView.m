//
//  DanmuItemView.m
//  Danmu
//
//  Created by mac on 2017/5/5.
//  Copyright © 2017年 shaowu. All rights reserved.
//

#import "DanmuItemView.h"
#import <Masonry.h>
#import "DanmuItem.h"
#import "UIView+Extension.h"

@implementation DanmuItemView
{
    NSMutableDictionary *attrs;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textColor = [UIColor blueColor];
        self.label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
        }];
        
        attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = self.label.font;

        self.height = 30;
        [self sizeToFit];
    }
    return self;
}

- (void)setItem:(DanmuItem *)item
{
    if (_item != item) {
        _item = item;
        self.label.text = item.text;
       
        CGSize size =  [item.text boundingRectWithSize:CGSizeMake( MAXFLOAT,self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        self.width = size.width;
    }
}

- (void)prepareForReuse
{
    self.item = nil;
}

//动画结束后将danmuItemView移除
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([self.delegate respondsToSelector:@selector(danmuItemViewWillRemoveFromSuperView:)]) {
        [self.delegate danmuItemViewWillRemoveFromSuperView:self];
    }
    
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}


-(void)setHeight:(CGFloat)height
{
    if (_height != height) {
        _height = height;
        [self setNeedsDisplay];
    }
}

@end
