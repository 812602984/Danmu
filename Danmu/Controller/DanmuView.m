//
//  DanmuView.m
//  Danmu
//
//  Created by mac on 2017/5/5.
//  Copyright © 2017年 shaowu. All rights reserved.
//

#import "DanmuView.h"
#import "DanmuItemView.h"
#import "UIView+Extension.h"

@interface DanmuView () <DanmuItemViewDelegate>
{
    CGFloat       * _maxPosX;
    NSUInteger    * _danmuCounts;
}

@property (nonatomic, strong)NSMutableArray <DanmuItemView *> *reusableItemViews;

@end

@implementation DanmuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.numberOfLines = 3;   //默认3行
        self.reusableItemViews = [NSMutableArray array];
    }
    return self;
}


- (void)addDanmu:(DanmuItem *)item
{
    DanmuItemView *view = [self dequeueReusableView];
    if (!view) {
        view = [[DanmuItemView alloc] init];
        view.delegate = self;
        
    }
    view.item = item;
    [view sizeToFit];
    
    CGFloat offset = 0.f;
    NSInteger line = [self findProperLineWithDelay:&offset];
    
    CGFloat posY = view.height / 2 + line * view.height;
    view.center = CGPointMake(view.width / 2 + self.width, posY);
    view.tag = line;
    
    CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnim.fromValue = @(view.centerX + offset);
    moveAnim.toValue = @(-view.width);
    moveAnim.duration = (view.width + offset + self.width) / 80.f;
    moveAnim.fillMode = kCAFillModeBoth;
    moveAnim.removedOnCompletion = YES;
    moveAnim.delegate = view;
    
    [self addSubview:view];
    [view.layer addAnimation:moveAnim
                      forKey:@"Fly"];

}

- (DanmuItemView *)dequeueReusableView
{
    DanmuItemView *view = nil;
    if (self.reusableItemViews.count) {
        view = self.reusableItemViews.firstObject;
        [self.reusableItemViews removeObject:view];
        [view prepareForReuse];
    }
    return view;
}

- (NSInteger)findProperLineWithDelay:(CGFloat *)offset
{
    NSInteger idx = NSNotFound;
    
    /*
     void *memset(void *s, int ch, size_t n);
     函数解释：将s中当前位置后面的n个字节 （typedef unsigned int size_t ）用 ch 替换并返回 s 。
     memset：作用是在一段内存块中填充某个给定的值，它是对较大的结构体或数组进行清零操作的一种最快方法
     */
    memset(_maxPosX, 0, sizeof(CGFloat) * _numberOfLines);
    memset(_danmuCounts, 0, sizeof(NSUInteger) * _numberOfLines);
    
    // 计算所有行弹幕的最大 X
    [self.subviews enumerateObjectsUsingBlock:^(__kindof DanmuItemView * obj, NSUInteger idx, BOOL * stop) {
        ++_danmuCounts[obj.tag];
        CGFloat x = [[obj.layer.presentationLayer valueForKeyPath:@"position.x"] floatValue];
        if (x > _maxPosX[obj.tag]) {
            _maxPosX[obj.tag] = x;
        }
    }];
    
    // 找到最小的 最大 X
    CGFloat minX = CGFLOAT_MAX;
    for (NSInteger i = 0; i < _numberOfLines; ++i) {
        if (_maxPosX[i] < minX) {
            minX = _maxPosX[i];
            idx = i;
        }
        else if (_maxPosX[i] == minX && idx != NSNotFound && _danmuCounts[i] < _danmuCounts[idx]) {
            idx = i;
        }
    }
    
    if (offset) {
        *offset = MAX(0.f, (minX - self.width));
        if (*offset > 0.f) {
            *offset += 64.f;
        }
    }
    
    return idx;
}

- (void)setNumberOfLines:(NSUInteger)numberOfLines
{
    if (_numberOfLines != numberOfLines) {
        _numberOfLines = numberOfLines;
        if (_maxPosX) {
            free(_maxPosX);
        }
        if (_danmuCounts) {
            free(_danmuCounts);
        }
        _maxPosX = malloc(sizeof(CGFloat) * _numberOfLines);
        memset(_maxPosX, 0, sizeof(CGFloat) * _numberOfLines);
        
        _danmuCounts = malloc(sizeof(NSUInteger) * _numberOfLines);
        memset(_danmuCounts, 0, sizeof(NSUInteger) * _numberOfLines);
    }
}

- (void)dealloc
{
    if (_maxPosX) {
        free(_maxPosX);
        _maxPosX = NULL;
    }
    if (_danmuCounts) {
        free(_danmuCounts);
        _danmuCounts = NULL;
    }
}

- (void)danmuItemViewWillRemoveFromSuperView:(DanmuItemView *)view
{
    [self.reusableItemViews addObject:view];
}

@end
