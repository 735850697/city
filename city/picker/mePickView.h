//
//  mePickView.h
//  city
//
//  Created by dbjyz on 15/12/25.
//  Copyright © 2015年 dbjyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mePickView;
@protocol mePickViewDelegate <NSObject>

-(void)selectCity:(NSString *)city;
@end


@interface mePickView : UIView

@property(nonatomic, assign)id<mePickViewDelegate>delegate;

@end
