//
//  AirbnbSearchViewDelegate.m
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//


#import "AirbnbSearchViewDelegate.h"
@interface AirbnbSearchViewDelegate()
@property (nonatomic,copy)TextDidChangeBlock atextChangeBlock ;

@end
@implementation AirbnbSearchViewDelegate

- (id)initWithBlock:(TextDidChangeBlock)textChangeBlock {
    self = [super init] ;
    if (self) {
        self.atextChangeBlock = textChangeBlock ;
    }
    return self ;
}


- (void)handleSearchBarDelegate:(UISearchBar *)searchBar {
    searchBar.delegate = self ;
}


#pragma maker --
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.atextChangeBlock(searchBar.text) ;
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES ;
}
@end
