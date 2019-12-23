//
//  MessagesCell.h
//  XNJPushAPP
//
//  Created by 罗函 on 16/5/20.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesCell : UITableViewCell
@property (nonatomic, retain) NSString *key;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *message;
- (void)setValueWithIndexPath:(NSIndexPath *)indexPath dic:(NSDictionary *)dic  titles:(NSArray *)titles;
@end
