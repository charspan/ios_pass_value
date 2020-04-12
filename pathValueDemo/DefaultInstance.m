//
//  DefaultInstance.m
//  pathValueDemo
//
//  Created by 志良潘 on 2020/4/7.
//  Copyright © 2020 志良潘. All rights reserved.
//

#import "DefaultInstance.h"

static DefaultInstance *sharedVC = nil;

@implementation DefaultInstance

// 通过类方法创建单例对象
+(instancetype)sharedInstance {
    @synchronized(self) {//任意对象
        if (sharedVC == nil) {
            sharedVC =[[DefaultInstance alloc]init];
        }
    }
    return sharedVC;
}

@end
