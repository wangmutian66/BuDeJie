//
//  WMTLoginRegister.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/27.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTLoginRegister.h"

@interface WMTLoginRegister ()

@end

@implementation WMTLoginRegister
+(instancetype) loginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+(instancetype) registerView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][1];
}


//页面加载的时候调用
-(void)awakeFromNib{
    [super awakeFromNib] ;
    //让我的按钮背景颜色不被拉伸
    UIImage *image=  _btnlogin.currentBackgroundImage;
    image=[image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    
    [_btnlogin setBackgroundImage:image forState:UIControlStateNormal];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
