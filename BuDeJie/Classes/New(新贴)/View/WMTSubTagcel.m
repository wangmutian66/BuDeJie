//
//  WMTSubTagcel.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/26.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTSubTagcel.h"
#import "UIImageView+WebCache.h"
#import "WMTSubTagItem.h"
@interface WMTSubTagcel()
@property (weak, nonatomic) IBOutlet UIImageView *IconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numberView;

@end;
@implementation WMTSubTagcel
-(void) setItem:(WMTSubTagItem *) item1{
    _item = item1;
    _nameView.text=item1.theme_name;
    
    //判断有没有大于一万
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",item1.sub_number] ;
    NSInteger num=item1.sub_number.integerValue;
    if(num > 10000){
        CGFloat numF=num/10000;
        numStr=[NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr=[numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    
    _numberView.text=numStr;
    [_IconView sd_setImageWithURL:[NSURL URLWithString:item1.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

 //从xib加载就会调用 调用一次

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // 设置圆角
    _IconView.layer.cornerRadius=30;
    _IconView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
