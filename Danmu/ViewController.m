//
//  ViewController.m
//  Danmu
//
//  Created by mac on 2017/5/6.
//  Copyright © 2017年 shaowu. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "DanmuView.h"
#import "DanmuItem.h"

@interface ViewController ()

@property (nonatomic, strong) DanmuView *danmuView;

@end

@implementation ViewController

- (DanmuView *)danmuView
{
    if (!_danmuView) {
        _danmuView = [[DanmuView alloc] initWithFrame:CGRectMake(0, 240, self.view.width, 200)];
        _danmuView.backgroundColor = [UIColor redColor];
        //        [self.view addSubview:_danmuView];
    }
    return _danmuView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.danmuView];
}

- (void)postText:(NSString *)text
{
    DanmuItem *item = [DanmuItem itemWithText:text];
    [self.danmuView addDanmu:item];
}

- (IBAction)start
{
    [self postText:@"nihao"];
    [self postText:@"124353678987098"];
    [self postText:@"哈哈哈哈哈哈哈哈哈哈哈😄😄😄😄😄😄😄"];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self postText:@"13245678908-097"];
        [self postText:@"sagdhgfdf"];
        
    });
}


@end
