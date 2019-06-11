//
//  AirbnbTableDataDelegate.m
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//

#import "AirbnbTableDataDelegate.h"
#import "UITableViewCell+Extension.h"

@interface AirbnbTableDataDelegate ()
@property (nonatomic, strong) NSMutableArray *items ;
@property (nonatomic, copy) NSString *cellIdentifier ;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock ;
@property (nonatomic, copy) CellHeightBlock             heightConfigureBlock ;
@property (nonatomic, copy) DidSelectCellBlock          didSelectCellBlock ;
@end

@implementation AirbnbTableDataDelegate

- (id)initWithItems:(NSMutableArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
    cellHeightBlock:(CellHeightBlock)aHeightBlock
     didSelectBlock:(DidSelectCellBlock)didselectBlock
{
    self = [super init] ;
    if (self) {
        self.items = anItems ;
        self.cellIdentifier = aCellIdentifier ;
        self.configureCellBlock = aConfigureCellBlock ;
        self.heightConfigureBlock = aHeightBlock ;
        self.didSelectCellBlock = didselectBlock ;
    }
    
    return self ;
}
- (void)resetItems:(NSMutableArray *)newItems {
    self.items = newItems ;
}

- (void)catItems:(NSArray *)newItems {
    [self.items addObjectsFromArray:newItems] ;
}

- (void)clearItems {
    if (self.items) {
        [self.items removeAllObjects] ;
    }
    
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(int)indexPath.row] ;
}

- (void)handleTableViewDatasourceAndDelegate:(UITableView *)table
{
    table.dataSource = self ;
    table.delegate   = self ;
}

#pragma mark --
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier] ;
    if (!cell) {
        [UITableViewCell registerTable:tableView nibIdentifier:self.cellIdentifier] ;
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    }
    self.configureCellBlock(indexPath,item,cell) ;
    return cell ;
}


#pragma mark --
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    return self.heightConfigureBlock(indexPath,item) ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self itemAtIndexPath:indexPath] ;
    self.didSelectCellBlock(indexPath,item) ;
}

@end
