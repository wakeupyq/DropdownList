//
//  ViewController.m
//  LeftDemo
//
//  Created by 杨琴 on 15/11/28.
//  Copyright © 2015年 wakeup. All rights reserved.
//

#import "ViewController.h"
#import "CustomHeaderView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, CustomHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSDictionary *datas;
@property (nonatomic, copy) NSArray *Keys;
@property (nonatomic, strong) CustomHeaderView *currentHeader;
@property (nonatomic, strong) NSMutableArray *heads;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDatas];
    [self layoutUI];
}

- (void)initDatas {
    self.datas = @{@"分组1，用代码添加约束至视图是，需要先将该视图加入至父视图上":@[@"1", @"2", @"3"],@"分组2":@[@"1"], @"分组3":@[@"1", @"2", @"3"]};
    self.Keys = self.datas.allKeys;
    
    // 初始化所有tableview的header
    for (int i = 0; i < self.Keys.count; i++) {
        CustomHeaderView *view = [[CustomHeaderView alloc] init];
        view.delegate = self;
        [view setBackgroundColor:[UIColor grayColor] withState:SelecteStateNormale];
        [view setBackgroundColor:[UIColor redColor] withState:SelecteStateSelected];
        view.index = i;
        view.lable.text = self.Keys[i];
        [self.heads addObject:view];
    }
}

- (void)layoutUI {
    //设置默认选择第一个headerview
    [self customHeaderViewDidSelected:self.heads[0]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

   return  self.Keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.datas objectForKey:self.Keys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellidentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.datas objectForKey:self.Keys[indexPath.section]][indexPath.row];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    return self.heads[section];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = [self stringHegiht:self.Keys[section] withFontSize:16];
    
    if (height > 44) {
        height += 20;
    } else {
        height = 44;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (self.currentHeader.index == indexPath.section && self.currentHeader) {
        height = 44;
    }
    return height;

}

#pragma mark - CustomHeaderViewDelegate

- (void)customHeaderViewDidSelected:(CustomHeaderView *)view {
    
    if (self.currentHeader == view) {
        return;
    }else if (self.currentHeader == nil) {
        view.selected = YES;
        self.currentHeader = view;
    }
    else {
        view.selected = YES;
        self.currentHeader.selected = NO;
        self.currentHeader = view;
    }
      [self.tableView reloadData];
}

#pragma mark - methead

// 根据字符串长度返回高度
- (CGFloat)stringHegiht:(NSString *)string withFontSize:(CGFloat)fontSize {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributeDic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName:[UIColor blackColor], NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributeDic context:nil].size;
    return size.height;
}

#pragma mark - getter

- (NSMutableArray *)heads {
    if (_heads == nil) {
        _heads = [NSMutableArray array];
    }
    return _heads;
}

@end
