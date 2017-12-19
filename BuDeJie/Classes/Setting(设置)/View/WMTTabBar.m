//
//  WMTTabBar.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/16.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTTabBar.h"
#import "UIView+Frame.h"

// 懒加载。部分的代码
@interface WMTTabBar()

@property(nonatomic,weak) UIButton *plusButton;

@end

@implementation WMTTabBar
-(UIButton *)plusButton
{
    if(!_plusButton){
        UIButton *plusButton =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [plusButton setBackgroundImage:[UIImage imageNamed: @"na3"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed: @"jiaclick"] forState:UIControlStateHighlighted];
        _plusButton=plusButton;
        [plusButton sizeToFit];
        [self addSubview:plusButton];
        
    }
    return _plusButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//中间的按钮不能加在这里 这里会调用很多次，可以使用懒加载
-(void) layoutSubviews
{
    [super layoutSubviews];
    // 布局tabBarButton
//    NSLog(@"==>%@",self.subviews);
    NSInteger count=self.items.count + 1;
    CGFloat btnW = self.wmt_width/ count;
    CGFloat btnH = self.wmt_height;
    CGFloat btnX = 0;
    NSInteger i = 0;
    //保证中间的按钮只加一次 可以使用懒加载
    for (UIView *tabBar in self.subviews) {
        //如果引用私有的类得用这种方式
        if([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]){
        
            if(i == 2){
                i += 1;
            }
            btnX = i * btnW;
            
            tabBar.frame=   CGRectMake(btnX, 0, btnW, btnH);
            i++;
        }
    }
    //设置 我加号按钮的center
    //CGRectMake(self.frame.size.width*0.5, self.frame.size.height*0.5, <#CGFloat width#>, <#CGFloat height#>)
    self.plusButton.center=CGPointMake(self.wmt_width*0.5, self.wmt_height*0.5);
    
}


@end
