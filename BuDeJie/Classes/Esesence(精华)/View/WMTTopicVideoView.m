//
//  WMTTopicVideoView.m
//  BuDeJie
//
//  Created by wangmutian on 2018/2/16.
//  Copyright © 2018年 wangmutian. All rights reserved.
//

#import "WMTTopicVideoView.h"
#import "WMTTopic.h"
#import "UIImageView+WebCache.h"
@interface WMTTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcount;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation WMTTopicVideoView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setTopic:(WMTTopic *)topic{
    _topic=topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0]];
    self.playcount.text = [NSString stringWithFormat:@"%zd播放",topic.playcount ];
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%zd:%zd",topic.voicetime/60,topic.voicetime%60];
    
}

@end
