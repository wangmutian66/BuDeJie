//
//  UIBarButtonItem+Item.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/17.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+(UIBarButtonItem *) itemWithimage1:(UIImage *) image hightImage:(UIImage *) hightimage
 target:(id)target action:(SEL)action{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hightimage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *containView=[[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}

+(UIBarButtonItem *) backItemWithimage1:(UIImage *) image hightImage:(UIImage *) hightimage   target:(id)target action:(SEL)action
                                  title:(NSString *) title{
    //设置导航条左边按钮
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:hightimage forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}


@end
