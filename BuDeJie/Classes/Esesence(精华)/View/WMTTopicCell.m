//
//  WMTTopicCell.m
//  BuDeJie
//
//  Created by wangmutian on 2018/2/8.
//  Copyright © 2018年 wangmutian. All rights reserved.
//storyboard 就是来写控制器的 不能写cell
//day08 10

#import "WMTTopicCell.h"
#import "WMTTopic.h"

@implementation WMTTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTopic:(WMTTopic *)topic
{
    _topic = topic;
}


@end
