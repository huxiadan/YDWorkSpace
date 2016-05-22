//
//  YBPersonalCenterVC.m
//  YBFreight
//
//  Created by lowell on 5/22/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import "YBPersonalCenterVC.h"
@interface YBPersonalCenterVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIButton *avatarBtn;

- (UITableView *)tableView;
- (UIView *)tableHeaderView;

@end

@implementation YBPersonalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI {
    self.title = @"我的";
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    return _tableView;
}

- (UIView *)tableHeaderView {
    if (_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 100)];
        
        UIButton *avatarBtn;
        [avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        
//        [avatarBtn sd_setImageWithURL:[NSURL new] forState:UIControlStateNormal placeholderImage:nil];
    }
    return _tableHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
