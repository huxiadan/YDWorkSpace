//
//  WaterFallFlowViewController.m
//  LowellsTestDemo
//
//  Created by lowell on 3/31/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import "WaterFallFlowViewController.h"
#import "YDCommonWaterFallFlowLayout.h"

static NSString * const reuseId = @"collCell";

@interface WaterFallFlowViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, YDCommonWaterFallFlowLayoutDelegate> {
    UICollectionView *_collectionView;
}

@end

@implementation WaterFallFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"瀑布流";
    
    YDCommonWaterFallFlowLayout *layout = [YDCommonWaterFallFlowLayout layoutWithColumnCount:3 horizonalSpace:5 verticalSpace:10 sectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseId];
    [self.view addSubview:_collectionView];
    [_collectionView reloadData];
}


#pragma mark -------------------- UICollectionView delegate & dataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    if (nil == cell) {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


#pragma mark -------------------- YDCommonWaterFallFlowLayoutDelegate methods

- (CGFloat)waterFallFlowLayout:(YDCommonWaterFallFlowLayout *)layout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath {
    static NSMutableDictionary *heightCache = nil;
    if (!heightCache) {
        heightCache = [NSMutableDictionary new];
    }
    NSString *cacheKey = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
    if (![heightCache valueForKey:cacheKey]) {
        [heightCache setValue:@(width+arc4random_uniform(100)) forKey:cacheKey];
        return (width+arc4random_uniform(100));
    } else {
        return [[heightCache valueForKey:cacheKey] floatValue];
    }
}

@end
