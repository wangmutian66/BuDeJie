//
//  UIBarButtonItem+Item.h
//  BuDeJie
//
//  Created by wangmutian on 2017/12/17.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
//快速创建UIBarButtonItem
+(UIBarButtonItem *) itemWithimage1:(UIImage *) image hightImage:(UIImage *) hightimage  target:(id)target action:(SEL)action;
+(UIBarButtonItem *) backItemWithimage1:(UIImage *) image hightImage:(UIImage *) hightimage   target:(id)target action:(SEL)action title:(NSString *) title; 
@end
