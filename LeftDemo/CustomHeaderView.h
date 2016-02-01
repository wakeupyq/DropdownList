//
//  CustomHeaderView.h
//  LeftDemo
//
//  Created by 杨琴 on 15/11/29.
//  Copyright © 2015年 wakeup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SelecteState) {
   SelecteStateNormale = 0,
   SelecteStateSelected = 1
};

@class CustomHeaderView;

@protocol CustomHeaderViewDelegate <NSObject>

- (void)customHeaderViewDidSelected:(CustomHeaderView *)view;

@end

@interface CustomHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<CustomHeaderViewDelegate> delegate;

- (void)setBackgroundColor:(UIColor *)backgroundColor withState:(SelecteState)state;
@end
