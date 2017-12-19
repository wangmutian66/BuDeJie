//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/14.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
+(UIImage *)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image=[UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
