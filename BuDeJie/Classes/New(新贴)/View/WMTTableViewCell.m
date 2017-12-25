//
//  WMTTableViewCell.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/25.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTTableViewCell.h"
#import "WMTSubTagItem.h"
#import "UIImageView+WebCache.h"
@interface WMTTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;

@end

@implementation WMTTableViewCell
-(void)setItem:(WMTSubTagItem *)item{
    _item=item;
    _nameView.text=item.theme_name;
    _numView.text=item.sub_number;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list]
                 placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
