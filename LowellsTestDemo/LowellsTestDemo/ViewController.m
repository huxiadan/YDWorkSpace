//
//  ViewController.m
//  LowellsTestDemo
//
//  Created by lowell on 3/31/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSMutableArray *_cells;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Demos";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self generateCells];
    [_tableView reloadData];
}

- (void)generateCells {
    _cells = [NSMutableArray array];
    
    [_cells addObject:@"WaterFallFlow"];
    
    [_cells addObject:@"JSPatch"];
    
    [_cells addObject:@"JSQMsg"];
    
    [_cells addObject:@"ShareSDK"];
    
    [_cells addObject:@"YDTags"];
}

#pragma mark ------------------ UITableView delegate & datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    NSString *classPrefix = [_cells objectAtIndex:indexPath.row];
    cell.textLabel.text = classPrefix;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *classPrefix = [_cells objectAtIndex:indexPath.row];
    Class class = NSClassFromString([NSString stringWithFormat:@"%@ViewController", classPrefix]);
    id vc = [class new];
    [(UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController pushViewController:vc animated:YES];
}

@end
