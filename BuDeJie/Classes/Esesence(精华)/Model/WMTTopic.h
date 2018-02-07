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
@property(nonatomic,copy) NSString *profile_name;
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
@end
