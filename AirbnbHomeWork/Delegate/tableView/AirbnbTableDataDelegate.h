//
//  AirbnbTableDataDelegate.h
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void    (^TableViewCellConfigureBlock)(NSIndexPath *indexPath, id item, UITableViewCell *cell) ;
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id item) ;
typedef void    (^DidSelectCellBlock)(NSIndexPath *indexPath, id item) ;



@interface AirbnbTableDataDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>
//初始化
- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
    cellHeightBlock:(CellHeightBlock)aHeightBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock ;
//设置代理、数据源
- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table ;
//创建cell获取特定位置的数据
- (id)itemAtIndexPath:(NSIndexPath *)indexPath ;
//重新设定数据
- (void)resetItems:(NSArray *)newItems ;
//请求更多的数据后使用
- (void)catItems:(NSArray *)newItems ;
//清空数据
- (void)clearItems ;

@end
