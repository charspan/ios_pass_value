//
//  NextViewController.m
//  pathValueDemo
//
//  Created by 志良潘 on 2020/4/6.
//  Copyright © 2020 志良潘. All rights reserved.
//

#import "NextViewController.h"
#import "DefaultInstance.h"

@interface NextViewController ()

// 属性传值文本
@property(nonatomic, strong) UITextField *attributeTF;
// 单例传值文本
@property(nonatomic, strong) UITextField *singleInstanceTF;
// NSUserDefaults传值文本
@property(nonatomic, strong) UITextField *nsUserDefaultsTF;
// 代理传值文本--主要应用于反向传值
@property(nonatomic, strong) UITextField *delegateTF;
// block传值文本--主要应用于反向传值
@property(nonatomic, strong) UITextField *blockTF;
// 通知传值
@property(nonatomic, strong) UITextField *notifyTF;
// 跳转
@property(nonatomic, strong) UIButton *btn;

@end

@implementation NextViewController

// 懒加载方式
-(UITextField *)attributeTF {
    if (!_attributeTF) {
        _attributeTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 200, 200, 40)];
        // 文字颜色
        _attributeTF.textColor = [UIColor blackColor];
        // 边框
        _attributeTF.borderStyle =UITextBorderStyleLine;
        _attributeTF.text = _str; // self.str 类内用成员变量
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
        _singleInstanceTF.text = [DefaultInstance sharedInstance].str;
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
        // NSUserDefaults传值--从文件中读取
        _nsUserDefaultsTF.text =  [[NSUserDefaults standardUserDefaults] objectForKey:@"NSUserDefaults"];
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
        _delegateTF.text =  @"代理传值-传递值";
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
        _blockTF.text =  @"block传值-传递值";
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
        _notifyTF.text =  @"通知传值-传递值";
    }
    return _notifyTF;
}

-(UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 200, 40)];
        _btn.backgroundColor =[UIColor redColor];
        [_btn setTitle:@"跳转回页面1" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

// 点击-回到页面1
- (void)btnClick {
    // 单例传值--反向传递
    [DefaultInstance sharedInstance].str = self.singleInstanceTF.text;
    // NSUserDefaults传值--反向传递
    [[NSUserDefaults standardUserDefaults] setObject:self.nsUserDefaultsTF.text forKey:@"NSUserDefaults-re"];
     // 同步一下才能真正的写数据
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 代理传值--反向传递
    [self.delegate passValue:self.delegateTF.text];
    // block传值--反向传递
    self.block(self.blockTF.text);
    // 通知传值--发送通知,发送名为notify的通知，object发送给谁，nil代表任何人可以接收，userInfo为通知信息是字典类型数据
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify" object:nil userInfo:@{@"msg":self.notifyTF.text}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
