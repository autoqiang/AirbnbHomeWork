//
//  ViewController.m
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//

#import "ViewController.h"
#import "AirbnbTableDataDelegate.h"
#import "AirbnbSearchViewDelegate.h"
#import "MyCell.h"
#import "MyObj.h"
#import "UITableViewCell+Extension.h"
#import <MJRefresh.h>
static NSString *const MyCellIdentifier = @"MyCell" ; // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *list ;
@property (nonatomic,strong) AirbnbTableDataDelegate *tableHandler ;
@property (nonatomic,strong) AirbnbSearchViewDelegate * searchHandler ;
@property (nonatomic,assign) NSInteger pages ;
@property (nonatomic,copy) NSString * qname ;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad] ;
    [self setupTableView] ;
    [self setfooter] ;
    [self setupSearchBar] ;
    [self setothers] ;
    
}
//初始化activityindicator
- (void)setothers {
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    [self.view addSubview:self.activityIndicator];
    
    self.activityIndicator.frame= CGRectMake([UIScreen mainScreen].bounds.size.width/2-50, [UIScreen mainScreen].bounds.size.height/2-50, 100, 100);
    
    self.activityIndicator.color = [UIColor blackColor];
    
    self.activityIndicator.backgroundColor = [UIColor clearColor];
    self.activityIndicator.hidesWhenStopped = YES;
}
//设置上拉刷新
- (void)setfooter {
    self.pages = 1 ;
    __weak __typeof(self) weakSelf = self;
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }];
    [self.table.mj_footer endRefreshingWithNoMoreData] ;
}
//上拉刷新回调的函数
- (void)loadMoreData {
    self.pages ++ ;
    NSLog(@"%ld",(long)self.pages) ;
    [self loadDataWithName:self.qname Page:[NSString stringWithFormat:@"%ld",(long)self.pages] andBlock:^(NSArray *array) {
        if (![[[array firstObject] valueForKey:@"name"] isEqual:@"什么都没有啊！！"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableHandler catItems:array] ;
                [self.table reloadData] ;
                [self.table.mj_footer endRefreshing];
            }) ;
        }else {
            [self.table.mj_footer endRefreshingWithNoMoreData];
        }
        
    }] ;
    
}
//向服务器申请数据的函数
- (void)loadDataWithName:(NSString *) name Page:(NSString *)page andBlock:(void(^)(NSMutableArray * array) )completion {
    
    NSMutableArray * array = [[NSMutableArray alloc]init];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/users/%@/repos?page=%@",name,page]] ;
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url] ;
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration] ;
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config] ;
    
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return ;
        }
        
        NSDictionary *dictFromData = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&error];
        
        if (dictFromData) {
            
            for (NSDictionary * dic in dictFromData) {
                MyObj * temp = [[MyObj alloc]init] ;
                temp.name = dic[@"name"] ;
                temp.stargazers_count = [dic[@"stargazers_count"] integerValue];
                temp.avatar_url = [dic[@"owner"] valueForKey:@"avatar_url"] ;
                temp.height = 50 ;
                [array addObject:temp] ;
            }
        }
        
        if([array isKindOfClass:[NSArray class]] && array.count > 0) {
            
        }else {
            MyObj * empty = [[MyObj alloc]init] ;
            empty.name = @"什么都没有啊！！";
            empty.height = [UIScreen mainScreen].bounds.size.height-76 ;
            [array addObject:empty] ;
        }
        if (completion) {
            completion(array) ;
        }
        
    }];
    [task resume] ;
    
}
//设置searchBar代理
- (void)setupSearchBar {
    self.searchBar.barStyle = UIBarStyleBlack ;
    
    
    
    TextDidChangeBlock textChange = ^(NSString * changedText) {
        
        self.pages = 1 ;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator startAnimating] ;
        });
        
        
        [self loadDataWithName:changedText Page:[NSString stringWithFormat:@"%ld",(long)self.pages] andBlock:^(NSArray *array) {
            self.qname = changedText ;
            if (![[[array firstObject] valueForKey:@"name"] isEqualToString:@"什么都没有啊！！"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableHandler resetItems:array] ;
                    [self.table reloadData] ;
                    [self.table.mj_footer resetNoMoreData] ;
                    [self.activityIndicator stopAnimating] ;
                }) ;
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableHandler clearItems] ;
                    [self.table.mj_footer endRefreshingWithNoMoreData] ;
                    [self.activityIndicator stopAnimating] ;
                    [self.table reloadData] ;
                });
                
            }
            
        }] ;
    } ;
    self.searchHandler = [[AirbnbSearchViewDelegate alloc]initWithBlock:textChange] ;
    [self.searchHandler handleSearchBarDelegate:self.searchBar] ;
}
//设置tableview代理、数据源
- (void)setupTableView
{
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    //初始化cell
    TableViewCellConfigureBlock configureCell = ^(NSIndexPath *indexPath, MyObj *obj, UITableViewCell *cell) {
        [cell configure:cell
              customObj:obj
              indexPath:indexPath] ;
    } ;
    //cell高度设定
    CellHeightBlock heightBlock = ^CGFloat(NSIndexPath *indexPath, id item) {
        return [MyCell getCellHeightWithCustomObj:item
                                        indexPath:indexPath] ;
    } ;
    //点击事件
    DidSelectCellBlock selectedBlock = ^(NSIndexPath *indexPath, id item) {
        NSLog(@"click row : %@",@(indexPath.row)) ;
    } ;
    
    self.tableHandler = [[AirbnbTableDataDelegate alloc] initWithItems:self.list
                                                    cellIdentifier:MyCellIdentifier
                                                configureCellBlock:configureCell
                                                   cellHeightBlock:heightBlock
                                                    didSelectBlock:selectedBlock] ;
    
    [self.tableHandler handleTableViewDatasourceAndDelegate:self.table] ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
