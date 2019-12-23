//
//  ExtrasViewController.m
//  XNJPushAPP
//
//  Created by 罗函 on 16/5/20.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "ExtrasViewController.h"

@interface ExtrasViewController ()


@property (nonatomic, retain) UIBarButtonItem *rightBarButton;

@end

@implementation ExtrasViewController

- (UIBarButtonItem *)rightBarButton {
    if(!_rightBarButton) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(action_RightBarButton:)];
    }
    return _rightBarButton;
}

- (void)action_RightBarButton:(UIBarButtonItem *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    _dic = [[NSMutableDictionary alloc] init];
   
    if(_key00.text.length>0 && _value00.text.length>0) {
        [_dic setValue:_value00.text forKey:_key00.text];
    }
    
    if(_key01.text.length>0 && _value01.text.length>0) {
        [_dic setValue:_value01.text forKey:_key01.text];
    }
    
    if(_key02.text.length>0 && _value02.text.length>0) {
        [_dic setValue:_value02.text forKey:_key02.text];
    }
    
    if(_key03.text.length>0 && _value03.text.length>0) {
        [_dic setValue:_value03.text forKey:_key03.text];
    }
    
    if(_key04.text.length>0 && _value04.text.length>0) {
        [_dic setValue:_value04.text forKey:_key04.text];
    }
    
    if(_key05.text.length>0 && _value05.text.length>0) {
        [_dic setValue:_value05.text forKey:_key05.text];
    }
    
    if(_key06.text.length>0 && _value06.text.length>0) {
        [_dic setValue:_value06.text forKey:_key06.text];
    }
    
    
    if(_Block) _Block (self.dic);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Set Extras";
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
    int i = 0;
    for (NSString *key in self.dic) {
        switch (i) {
            case 0:{
                _key00.text = key;
                _value00.text = self.dic[key];
            }
                break;
            case 1:{
                _key01.text = key;
                _value01.text = self.dic[key];
            }
                break;
            case 2:{
                _key02.text = key;
                _value02.text = self.dic[key];
            }
                break;
            case 3:{
                _key03.text = key;
                _value03.text = self.dic[key];
            }
                break;
            case 4:{
                _key04.text = key;
                _value04.text = self.dic[key];
            }
                break;
            case 5:{
                _key05.text = key;
                _value05.text = self.dic[key];
            }
                break;
            case 6:{
                _key06.text = key;
                _value06.text = self.dic[key];
            }
                break;
                
            default:
                break;
        }
        i++;
    }
}


@end
