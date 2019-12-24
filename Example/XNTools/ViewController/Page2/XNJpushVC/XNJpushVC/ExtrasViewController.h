//
//  ExtrasViewController.h
//  XNJPushAPP
//
//  Created by 罗函 on 16/5/20.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "XNViewController.h"

@interface ExtrasViewController : XNViewController

@property (weak, nonatomic) IBOutlet UITextField *key00;
@property (weak, nonatomic) IBOutlet UITextField *key01;
@property (weak, nonatomic) IBOutlet UITextField *key02;
@property (weak, nonatomic) IBOutlet UITextField *key03;
@property (weak, nonatomic) IBOutlet UITextField *key04;
@property (weak, nonatomic) IBOutlet UITextField *key05;
@property (weak, nonatomic) IBOutlet UITextField *key06;


@property (weak, nonatomic) IBOutlet UITextField *value00;
@property (weak, nonatomic) IBOutlet UITextField *value01;
@property (weak, nonatomic) IBOutlet UITextField *value02;
@property (weak, nonatomic) IBOutlet UITextField *value03;
@property (weak, nonatomic) IBOutlet UITextField *value04;
@property (weak, nonatomic) IBOutlet UITextField *value05;
@property (weak, nonatomic) IBOutlet UITextField *value06;


@property (nonatomic, retain) NSMutableDictionary *dic;
@property (nonatomic, readwrite, copy) void (^Block)(NSMutableDictionary *);

@end
