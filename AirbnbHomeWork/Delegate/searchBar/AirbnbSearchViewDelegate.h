//
//  AirbnbSearchViewDelegate.h
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//提交搜索时调用
typedef void (^TextDidChangeBlock)(NSString * changedText) ;

@interface AirbnbSearchViewDelegate : NSObject<UISearchBarDelegate>
//初始化
-(id)initWithBlock:(TextDidChangeBlock)textChangeBlock ;
//设置代理
- (void)handleSearchBarDelegate:(UISearchBar *)searchBar ;

@end
