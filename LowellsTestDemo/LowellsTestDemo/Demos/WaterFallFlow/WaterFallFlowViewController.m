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
    NSInteger cellCount;
    NSMutableDictionary *heightCache;
}

@end

@implementation WaterFallFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"瀑布流";
    cellCount = 50;
    YDCommonWaterFallFlowLayout *layout = [YDCommonWaterFallFlowLayout layoutWithColumnCount:3 horizonalSpace:5 verticalSpace:5 sectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseId];
    [self.view addSubview:_collectionView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cellCount = 50;
        [_collectionView reloadData];
    });
}


#pragma mark -------------------- UICollectionView delegate & dataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    if (nil == cell) {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    }
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


#pragma mark -------------------- YDCommonWaterFallFlowLayoutDelegate methods

- (CGFloat)waterFallFlowLayout:(YDCommonWaterFallFlowLayout *)layout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath {
//    return (width+arc4random_uniform(100));
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
