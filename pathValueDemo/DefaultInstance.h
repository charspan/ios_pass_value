//
//  DefaultInstance.h
//  pathValueDemo
//
//  Created by 志良潘 on 2020/4/7.
//  Copyright © 2020 志良潘. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DefaultInstance : NSObject

+(instancetype)sharedInstance;

// 定义一个属性字符串
@property (nonatomic, strong) NSString *str;

@end

NS_ASSUME_NONNULL_END
