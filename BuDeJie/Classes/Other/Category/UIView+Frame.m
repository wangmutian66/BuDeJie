//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/17.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
-(void) setWmt_width:(CGFloat)wmt_width{
    CGRect rect=self.frame;
    rect.size.width=wmt_width;
    self.frame=rect;
}
-(CGFloat)wmt_width{
    return self.frame.size.width;
}

-(void) setWmt_height:(CGFloat)wmt_height{
    CGRect rect=self.frame;
    rect.size.width=wmt_height;
    self.frame=rect;
}
-(CGFloat)wmt_height{
    return self.frame.size.height;
}

-(void) setWmt_x:(CGFloat)wmt_x{
    CGRect rect=self.frame;
    rect.origin.x=wmt_x;
    self.frame=rect;
}
-(CGFloat)wmt_x{
    return self.frame.origin.x;
}

-(void) setWmt_y:(CGFloat)wmt_y{
    CGRect rect=self.frame;
    rect.origin.y=wmt_y;
    self.frame=rect;
}
-(CGFloat)wmt_y{
    return self.frame.origin.x;
}

-(void)setWmt_centerX:(CGFloat) wmt_centerX{
    CGPoint center = self.center;
    center.x=wmt_centerX;
    self.center=center;
}
-(CGFloat) wmt_centerX{
    return self.center.x;
}



@end
