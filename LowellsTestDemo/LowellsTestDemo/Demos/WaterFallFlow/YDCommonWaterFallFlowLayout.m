//
//  YDCommonWaterFallFlowLayout.m
//  LowellsTestDemo
//
//  Created by lowell on 3/31/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import "YDCommonWaterFallFlowLayout.h"

@interface YDCommonWaterFallFlowLayout()

@property (nonatomic, strong) NSMutableArray *colMaxHeights;//存每列的最大y
@property (nonatomic, strong) NSMutableArray *attributesCache;

@end

@implementation YDCommonWaterFallFlowLayout

+ (instancetype)layoutWithColumnCount:(NSInteger)count horizonalSpace:(CGFloat)hSpace verticalSpace:(CGFloat)vSpace sectionInset:(UIEdgeInsets)sInset {
    YDCommonWaterFallFlowLayout *layout = [[YDCommonWaterFallFlowLayout alloc] init];
    layout.horizonalSpace = hSpace;
    layout.verticalSpace = vSpace;
    layout.sectionInsets = sInset;
    layout.columnCount = count;
    return layout;
}

- (instancetype)init {
    if (self = [super init]) {
        _horizonalSpace = 0;
        _verticalSpace = 0;
        _sectionInsets = UIEdgeInsetsZero;
        _columnCount = 2;
        _attributesCache = [NSMutableArray new];
    }
    return self;
}

- (NSMutableArray *)colMaxHeights {
    if (!_colMaxHeights) {
        _colMaxHeights = [NSMutableArray array];
    }
    return _colMaxHeights;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    for (NSInteger i = 0; i < _columnCount; i++) {
        [self.colMaxHeights addObject:@0];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //得到每个item的属性值进行存储
    [_attributesCache removeAllObjects];
    for (NSInteger i = 0 ; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [_attributesCache addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    [self invalidateLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return NO;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat collectWidth = CGRectGetWidth(self.collectionView.bounds);
    CGFloat itemWidth = (collectWidth - _sectionInsets.left - _sectionInsets.right - (_columnCount - 1) * _horizonalSpace) / _columnCount;
    CGFloat itemHeight = [self.delegate waterFallFlowLayout:self heightForWidth:itemWidth andIndexPath:indexPath];
    
    __block NSInteger minYCol = 0;//计算哪列最短，下一个拼在最短的下面
    [self.colMaxHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([_colMaxHeights[minYCol] floatValue] > [obj floatValue]) {
            minYCol = idx;
        }
    }];
    
    CGFloat x = _sectionInsets.left + minYCol * (itemWidth + _horizonalSpace);
    
    CGFloat y = [_colMaxHeights[minYCol] floatValue] + (indexPath.item < _columnCount ? _sectionInsets.top : _verticalSpace);
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(x, y, itemWidth, itemHeight);
    self.colMaxHeights[minYCol] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributesCache;
}


- (CGSize)collectionViewContentSize {
    CGFloat maxY = 0;
    for (NSNumber *num in self.colMaxHeights) {
        maxY = MAX([num floatValue], maxY);
    }
    return CGSizeMake(0, maxY + _sectionInsets.bottom);
}

@end
