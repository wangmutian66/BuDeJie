//
//  WMTADItem.h
//  BuDeJie
//
//  Created by wangmutian on 2017/12/23.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMTADItem : NSObject

/*网络地址*/
@property (nonatomic,strong) NSString *w_picurl;

/*点击*/
@property (nonatomic,strong) NSString *winurl;

@property (nonatomic,assign)  CGFloat w;
@property (nonatomic,assign)  CGFloat h;

@end
