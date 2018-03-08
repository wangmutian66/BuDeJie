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
#import "UIImageView+WebCache.h"
#import "WMTTopicVideoView.h"
#import "WMTTopicVoiceView.h"
#import "WMTTopicPictureView.h"



@interface WMTTopicCell()
//控件的命名 - > 功能 + 控件类型
//nameLabel
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

/**图片控件**/
@property(nonatomic,weak) WMTTopicPictureView *pictureView;
/**声音控件**/
@property(nonatomic,weak) WMTTopicVoiceView *voiceView;
/**视频控件**/
@property(nonatomic,weak) WMTTopicVideoView *videoView;

@end

@implementation WMTTopicCell

-(WMTTopicPictureView *) pictureView{
    if(!_pictureView){
       
        WMTTopicPictureView *pictureView =  [WMTTopicPictureView wmt_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

-(WMTTopicVoiceView *) voiceView{
    if(!_voiceView){
        WMTTopicVoiceView *voiceView = [WMTTopicVoiceView wmt_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

-(WMTTopicVideoView *) videoView{
    if(!_videoView){
        WMTTopicVideoView *videoView = [WMTTopicVideoView wmt_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
//走的是xib 肯定走 这个方法 awakeFromNib
-(void) awakeFromNib
{
    NSLog(@"=====》到这里了吗？");
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(WMTTopic *)topic
{
    _topic = topic;
    

//    NSLog(@"=========>%@",topic.profile_image);
    //头像图片
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    //设置圆角
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2.0;
    self.profileImageView.layer.masksToBounds = YES;
    //设置顶
//    topic.ding = 0;
//    if(topic.ding > 10000){
//        [self.dingButton setTitle:[NSString stringWithFormat:@"%.1f万",topic.ding/10000.0] forState:UIControlStateNormal];
//    }else if(topic.ding > 0){
//        [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",topic.ding] forState:UIControlStateNormal];
//    }else if(topic.ding == 0){
//        [self.dingButton setTitle:@"顶" forState:UIControlStateNormal];
//    }
  
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.commit placeholder:@"评论"];
    
    
//    [self chuliwan:topic.ding];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text=topic.passtime;
    self.text_label.text = topic.text;
    //最热评论
    if(topic.top_cmt.count){ // 有最热评论
        self.topCmtView.hidden=NO;
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *connect = cmt[@"content"];
        if(connect.length == 0){
            connect = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        self.topCmtLabel.text= [NSString stringWithFormat:@"%@:%@",username,connect];
        
    }else{ //没有
        self.topCmtView.hidden = YES; 
    }
    
    
    //中间内容 09 - 07
    //1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
//    UIView *view = [[UIView alloc] init];
//    view.frame = CGRectMake(0, 0,100, 100);
//    view.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview: view];;
    if(topic.type == 10){ //图片
        self.pictureView.hidden = NO;
        self.voiceView.hidden= YES;
        self.videoView.hidden=YES;
    }else if(topic.type == 31){

        self.pictureView.hidden=YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden=YES;
       
    }else if(topic.type == 41){
        self.pictureView.hidden=YES;
        self.voiceView.hidden= YES;
        self.videoView.hidden = NO;
         self.videoView.topic = topic;
    }else if(topic.type == 29){
        self.pictureView.hidden=YES;
        self.voiceView.hidden= YES;
        self.videoView.hidden=YES;
    }
    
    
    
    
}

-(void)setupButtonTitle:(UIButton *)button number:(NSInteger) number placeholder:(NSString *) placeholder {
    if(number > 10000){
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/10000.0] forState:UIControlStateNormal];
    }else if(number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else if(number == 0){
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}


//修改cell 之间的间距
-(void)setFrame:(CGRect)frame{
//    frame.origin.x +=10;
//    frame.size.width -= 20;
    frame.size.height  -=10;
    [super setFrame: frame];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if(self.topic.type == 10){ //图片
        self.pictureView.frame = self.topic.middleFrame;
    }else if(self.topic.type == 31){
        self.voiceView.frame = self.topic.middleFrame;
    }else if(self.topic.type == 41){
        self.videoView.frame = self.topic.middleFrame;
    }
}
@end
