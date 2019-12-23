//
//  MessagesCell.m
//  XNJPushAPP
//
//  Created by 罗函 on 16/5/20.
//  Copyright © 2016年 罗函. All rights reserved.
//

#import "MessagesCell.h"

@implementation MessagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setValueWithIndexPath:(NSIndexPath *)indexPath dic:(NSDictionary *)dic titles:(NSArray *)titles {
    switch (indexPath.section) {
        case 0:{
            self.title.textColor = [UIColor colorWithRGB:0xf60f30 alpha:1];
            self.title.text = titles[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    self.key =@"appkey";
                    break;
                case 1:
                    self.key =@"mastersecret";
                    break;
                case 2:
                    self.key =@"platform";
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:{
            self.title.textColor = [UIColor blackColor];
            self.title.text = titles[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    self.key =@"alert";
                    break;
                case 1:
                    self.key =@"sound";
                    break;
                case 2:
                    self.key =@"badge";
                    break;
                case 3:
                    self.key =@"extras";
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:{
            self.title.textColor = [UIColor blackColor];
            self.title.text = titles[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    self.key =@"alert";
                    break;
                case 1:
                    self.key =@"title";
                    break;
                case 2:
                    self.key =@"builder_id";
                    break;
                case 3:
                    self.key =@"extras";
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    if(indexPath.row != 3)
        self.message.text = dic[_key];
    else{
        NSDictionary *extrasdic = dic[_key];
        if(!extrasdic)
            return;
        self.message.numberOfLines = 0;
        NSString *display = @"";
        for (NSString *key in extrasdic) {
            display = [display stringByAppendingString:[NSString stringWithFormat:@"%@ : %@\n", key, extrasdic[key]]];
        }
        if(display.length > 2) {
            display = [display substringToIndex:display.length - 1];
        }
        self.message.text = display;
    }
}
@end
