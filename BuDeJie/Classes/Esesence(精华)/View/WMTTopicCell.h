//
//  WMTTopicCell.h
//  BuDeJie
//
//  Created by wangmutian on 2018/2/8.
//  Copyright © 2018年 wangmutian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMTTopic;
@interface WMTTopicCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, strong) WMTTopic *topic;
@end
