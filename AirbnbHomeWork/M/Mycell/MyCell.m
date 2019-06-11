//
//  MyCell.m
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MyObj *myObj = (MyObj *)obj ;
        MyCell *mycell = (MyCell *)cell ;
        dispatch_async(dispatch_get_main_queue(), ^{
            mycell.lbTitle.text = myObj.name ;
            mycell.starLabel.text = [NSString stringWithFormat:@"%@", @(myObj.stargazers_count)] ;
        }) ;
        if (myObj.avatar_url) {
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:myObj.avatar_url]] ;
            UIImage * image = [UIImage imageWithData:data] ;
            dispatch_async(dispatch_get_main_queue(), ^{
                [mycell.image setImage:image] ;
            }) ;
        }
    }) ;
    
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    return ((MyObj *)obj).height ;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
