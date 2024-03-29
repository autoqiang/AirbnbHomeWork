//
//  UITableViewCell+Extension.m
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

#pragma mark --
+ (UINib *)nibWithIdentifier:(NSString *)identifier
{
    return [UINib nibWithNibName:identifier
                          bundle:nil] ;
}

#pragma mark - Public
+ (void)registerTable:(UITableView *)table
        nibIdentifier:(NSString *)identifier
{
    [table registerNib:[self nibWithIdentifier:identifier]
forCellReuseIdentifier:identifier] ;
}

#pragma mark --
#pragma mark - Rewrite these func in SubClass !
- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass !
    
}

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath
{
    // Rewrite this func in SubClass if necessary
    if (!obj) {
        return 0.0f ; // if obj is null .
    }
    return 44.0f ; // default cell height
}

@end
