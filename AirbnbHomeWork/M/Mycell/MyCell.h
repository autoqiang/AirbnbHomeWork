//
//  MyCell.h
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyObj.h"

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;

@end
