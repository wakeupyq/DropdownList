//
//  CustomHeaderView.m
//  LeftDemo
//
//  Created by 杨琴 on 15/11/29.
//  Copyright © 2015年 wakeup. All rights reserved.
//

#import "CustomHeaderView.h"
@interface CustomHeaderView()
{
    BOOL _flag;
}

@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *normalBackgroundColor;

@end

@implementation CustomHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initDatas];
        [self layoutUI];
    }
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initDatas];
        [self layoutUI];
    }
    return self;
}

- (void)initDatas {
    // 设置默认色未灰色
    self.normalBackgroundColor = [UIColor grayColor];
    self.selected = NO;
    self.index = 0;
}

- (void)layoutUI {
    
    self.lable = [[UILabel alloc] initWithFrame:self.bounds];
    self.lable.numberOfLines = 0;
    self.lable.lineBreakMode = NSLineBreakByWordWrapping;
    self.lable.font = [UIFont systemFontOfSize:16];
    self.lable.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.lable];
    
    // 设置自动布局,若为YES则不通过约束进行布局
    self.lable.translatesAutoresizingMaskIntoConstraints = NO;
    // 添加约束
    NSDictionary *dic = @{@"lable":self.lable};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[lable]-(0)-|" options:0 metrics:nil views:dic]];
   [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[lable]-(0)-|" options:0 metrics:nil views:dic]];

// 添加手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    [self addGestureRecognizer:gesture];
}


- (void)gestureAction:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(customHeaderViewDidSelected:)]) {
        [self.delegate customHeaderViewDidSelected:self];
    }
}

#pragma mark - meathd

- (void)setBackgroundColor:(UIColor *)backgroundColor withState:(SelecteState)state {
    if (state == SelecteStateSelected) {
        self.selectedBackgroundColor = backgroundColor;
    } else {
        self.normalBackgroundColor = backgroundColor;
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        // 若未设置选中的颜色，则选中颜色与未选中时的颜色一样
        if (self.selectedBackgroundColor == nil) {
            self.selectedBackgroundColor = self.normalBackgroundColor;
        }
        self.contentView.backgroundColor = self.selectedBackgroundColor;
    } else {
        self.contentView.backgroundColor = self.normalBackgroundColor;
    }
}

@end
