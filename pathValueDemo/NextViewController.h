//
//  NextViewController.h
//  pathValueDemo
//
//  Created by 志良潘 on 2020/4/6.
//  Copyright © 2020 志良潘. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 委托方-创建一个协议
@protocol passValueDelegate <NSObject>

// 协议定义一个传值的方法
- (void)passValue:(NSString *)str;

@end

@interface NextViewController : UIViewController

// 定义一个属性字符串
@property (nonatomic, strong) NSString *str;

// 定义一个持有协议的id指针，weak防止循环引用
@property (weak)id<passValueDelegate>delegate;

// 定义一个block进行页面反向传值，copy防止循环引用 ^ 是block的标志
@property (copy) void (^block)(NSString *);

@end

NS_ASSUME_NONNULL_END
