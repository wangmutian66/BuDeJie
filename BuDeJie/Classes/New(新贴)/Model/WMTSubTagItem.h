//
//  WMTSubTagItem.h
//  BuDeJie
//
//  Created by wangmutian on 2017/12/26.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import <Foundation/Foundation.h>
//image_list,sub_number,theme_name
@interface WMTSubTagItem : NSObject
@property(nonatomic,strong) NSString *theme_name;
@property(nonatomic,strong) NSString *sub_number;
@property(nonatomic,strong) NSString *image_list;
@end
