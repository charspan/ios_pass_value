//
//  ViewController.m
//  pathValueDemo
//
//  Created by 志良潘 on 2020/4/6.
//  Copyright © 2020 志良潘. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "DefaultInstance.h"

@interface ViewController ()<passValueDelegate> // 准守协议

// 属性传值文本
@property(nonatomic, strong) UITextField *attributeTF;
// 单例传值文本
@property(nonatomic, strong) UITextField *singleInstanceTF;
// NSUserDefaults传值文本
@property(nonatomic, strong) UITextField *nsUserDefaultsTF;
// 代理传值文本--主要应用于反向传值（两个页面建立代理关系）
@property(nonatomic, strong) UITextField *delegateTF;
// block传值文本--主要应用于反向传值
@property(nonatomic, strong) UITextField *blockTF;
// 通知传值 允许跨页面的传值 多对多的传值方式
@property(nonatomic, strong) UITextField *notifyTF;
// 跳转
@property(nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

-(UITextField *)attributeTF {
    if (_attributeTF == nil) {
        _attributeTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 200, 200, 40)];
        // 文字颜色
        _attributeTF.textColor = [UIColor blackColor];
        // 边框
        _attributeTF.borderStyle =UITextBorderStyleLine;
        _attributeTF.text = @"属性传值";
    }
    return _attributeTF;
}

-(UITextField *)singleInstanceTF {
    if (_singleInstanceTF == nil) {
        _singleInstanceTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 250, 200, 40)];
        // 文字颜色
        _singleInstanceTF.textColor = [UIColor blackColor];
        // 边框
        _singleInstanceTF.borderStyle =UITextBorderStyleLine;
        _singleInstanceTF.text = @"单例传值";
    }
    return _singleInstanceTF;
}

-(UITextField *)nsUserDefaultsTF {
    if (_nsUserDefaultsTF == nil) {
        _nsUserDefaultsTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 300, 200, 40)];
        // 文字颜色
        _nsUserDefaultsTF.textColor = [UIColor blackColor];
        // 边框
        _nsUserDefaultsTF.borderStyle =UITextBorderStyleLine;
        _nsUserDefaultsTF.text = @"NSUserDefaults传值";
    }
    return _nsUserDefaultsTF;
}

-(UITextField *)delegateTF {
    if (_delegateTF == nil) {
        _delegateTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 350, 200, 40)];
        // 文字颜色
        _delegateTF.textColor = [UIColor blackColor];
        // 边框
        _delegateTF.borderStyle =UITextBorderStyleLine;
        _delegateTF.text =  @"代理传值-等待值";
    }
    return _delegateTF;
}

-(UITextField *)blockTF {
    if (_blockTF == nil) {
        _blockTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 400, 200, 40)];
        // 文字颜色
        _blockTF.textColor = [UIColor blackColor];
        // 边框
        _blockTF.borderStyle =UITextBorderStyleLine;
        _blockTF.text =  @"block传值-等待值";
    }
    return _blockTF;
}

-(UITextField *)notifyTF {
    if (_notifyTF == nil) {
        _notifyTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 450, 200, 40)];
        // 文字颜色
        _notifyTF.textColor = [UIColor blackColor];
        // 边框
        _notifyTF.borderStyle =UITextBorderStyleLine;
        _notifyTF.text =  @"通知传值-等待值";
    }
    return _notifyTF;
}

-(UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 200, 40)];
        _btn.backgroundColor =[UIColor redColor];
        [_btn setTitle:@"跳转至页面2" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

// 点击-跳转至页面2
- (void)btnClick {
    NextViewController *nextVC = [[NextViewController alloc]init];
    // 属性传值--传递
    nextVC.str = _attributeTF.text;
    // 单例传值--传递
    [DefaultInstance sharedInstance].str = _singleInstanceTF.text;
    // NSUserDefaults传值--传递
    [[NSUserDefaults standardUserDefaults] setObject:_nsUserDefaultsTF.text forKey:@"NSUserDefaults"];
    // 同步一下才能真正的写数据
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 代理传值--设置代理关系
    nextVC.delegate = self;
    // block传值--实现block-接收来之页面2的值
    nextVC.block = ^(NSString *str){
        self.blockTF.text = str;
    };
    // 通知传值--添加监听--等待页面2的传值 监听名为notify的通知，发送方为nil代表任意
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyHandler:) name:@"notify" object:nil];
    // 隐藏tabbar
    nextVC.hidesBottomBarWhenPushed = YES;
    // 防止弹出界面不能占满屏幕
    nextVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nextVC animated:YES completion:nil];
}

// 接收到通知之后的处理--参数1:通知
- (void)notifyHandler:(NSNotification*) notify{
    self.notifyTF.text = notify.userInfo[@"msg"];
}

// 当页面即将显示的时候
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 单例传值--界面2没有传过来的时候显示默认值（单例传值）
    if([DefaultInstance sharedInstance].str != nil) {
        self.singleInstanceTF.text = [DefaultInstance sharedInstance].str;
    }
    // NSUserDefaults传值--界面2没有传过来的时候显示默认值（NSUserDefaults传值）
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"NSUserDefaults-re"] != nil) {
        self.nsUserDefaultsTF.text =  [[NSUserDefaults standardUserDefaults] objectForKey:@"NSUserDefaults-re"];
    }
}

// 代理传值--实现协议方法--接收来自页面2的值
- (void)passValue:(NSString *)str{
    self.delegateTF.text = str;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置页面背景色
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.attributeTF];
    [self.view addSubview:self.singleInstanceTF];
    [self.view addSubview:self.nsUserDefaultsTF];
    [self.view addSubview:self.delegateTF];
    [self.view addSubview:self.blockTF];
    [self.view addSubview:self.notifyTF];
    [self.view addSubview:self.btn];
}

@end
