//
//  JSPatchViewController.m
//  LowellsTestDemo
//
//  Created by lowell on 4/7/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import "JSPatchViewController.h"

@interface JSPatchViewController ()

@end

@implementation JSPatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"JSPatch";
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"crashBtn" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(crashTest) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)crashTest {
    NSArray *a = [NSArray new];
    NSLog(@"%@", a[0]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
