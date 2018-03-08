//
//  WMTTopic.h
//  BuDeJie
//
//  Created by wangmutian on 2018/2/7.
//  Copyright © 2018年 wangmutian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMTTopic : NSObject
/**用户的名字**/
@property(nonatomic,copy) NSString *name;
/**用户的头像**/
@property(nonatomic,copy) NSString *profile_image;
/**帖子文字内容**/
@property(nonatomic,copy) NSString *text;
/**帖子审核通过的时间**/
@property(nonatomic,copy) NSString *passtime;
/**顶数量**/
@property(nonatomic,assign) NSInteger ding;
/**踩数量**/
@property(nonatomic,assign) NSInteger cai;
/**转发分享数量**/
@property(nonatomic,assign) NSInteger repost;
/**评论数量**/
@property(nonatomic,assign) NSInteger commit;
/**最热评论**/
@property(nonatomic,strong) NSArray *top_cmt;
/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;

/**宽度**/
@property(nonatomic,assign) NSInteger width;
/**高度**/
@property(nonatomic,assign) NSInteger height;

/**中间内容的frame**/
@property(nonatomic,assign) CGRect middleFrame;

/**小图**/
@property(nonatomic,strong) NSString *image0;
/**中图**/
@property(nonatomic,strong) NSString *image2;
/**大图**/
@property(nonatomic,strong) NSString *image1;

/** 音频时长 **/
@property(nonatomic,assign) NSInteger voicetime;
/**视频时长**/
@property(nonatomic,assign) NSInteger videotime;
/**音频\视频播放次数**/
@property(nonatomic,assign) NSInteger playcount;


@end
