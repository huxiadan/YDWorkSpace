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
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger colForIndexPath = (indexPath.item % _columnCount);//indexPath对应第几列
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self getFrameByIndexPath:indexPath];
    self.colMaxHeights[colForIndexPath] = @(MAX([self.colMaxHeights[colForIndexPath] floatValue], attributes.frame.origin.y + attributes.frame.size.height));
    return attributes;
}

- (CGRect)getFrameByIndexPath:(NSIndexPath *)indexPath {
    CGFloat collectWidth = CGRectGetWidth(self.collectionView.bounds);
    CGFloat itemWidth = (collectWidth - _sectionInsets.left - _sectionInsets.right - (_columnCount - 1) * _horizonalSpace) / _columnCount;
    CGFloat itemHeight = [self.delegate waterFallFlowLayout:self heightForWidth:itemWidth andIndexPath:indexPath];
    NSInteger colForIndexPath = (indexPath.item % _columnCount);//indexPath对应第几列
    CGFloat x = _sectionInsets.left + colForIndexPath * (itemWidth + _horizonalSpace);
    if (indexPath.item - _columnCount > -1) {
        NSIndexPath *preIndexPath = [NSIndexPath indexPathForItem:indexPath.item-_columnCount inSection:0];
        CGRect preFrame = [self getFrameByIndexPath:preIndexPath];
        return CGRectMake(preFrame.origin.x, CGRectGetMaxY(preFrame) + _verticalSpace, itemWidth, itemHeight);
    }
    return CGRectMake(x, 0, itemWidth, itemHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    for (NSInteger i = 0; i < _columnCount; i++) {
        [self.colMaxHeights addObject:@0];
    }
    NSMutableArray *attrs = [[NSMutableArray alloc] init];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [attrs addObject:attr];
    }
    return attrs;
}


- (CGSize)collectionViewContentSize {
    CGFloat maxY = 0;
    for (NSNumber *num in self.colMaxHeights) {
        maxY = MAX([num floatValue], maxY);
    }
    return CGSizeMake(0, maxY + _sectionInsets.bottom);
}

@end
