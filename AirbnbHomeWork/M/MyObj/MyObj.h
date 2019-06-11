//
//  MyObj.h
//  AirbnbHomeWork
//
//  Created by auto on 2019/4/18.
//  Copyright © 2019年 auto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyObj : NSObject

@property (nonatomic, copy)      NSString *name ;
@property (nonnull, copy) NSString * avatar_url ;
@property (nonatomic)           CGFloat  height ;
@property (nonatomic,assign) NSInteger stargazers_count ;

@end
