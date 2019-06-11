//
//  UITableViewCell+Extension.h
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UITableViewCell (Extension)

+ (void)registerTable:(UITableView *)table
        nibIdentifier:(NSString *)identifier ;

- (void)configure:(UITableViewCell *)cell
        customObj:(id)obj
        indexPath:(NSIndexPath *)indexPath ;

+ (CGFloat)getCellHeightWithCustomObj:(id)obj
                            indexPath:(NSIndexPath *)indexPath ;

@end
