//
//  UIView+Frame.h
//  BuDeJie
//
//  Created by wangmutian on 2017/12/17.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
  写分类：避免跟其他开发者产生冲突，加前缀
 */
@interface UIView (Frame)

@property CGFloat wmt_width;
@property CGFloat wmt_height;
@property CGFloat wmt_x;
@property CGFloat wmt_y;

@end
