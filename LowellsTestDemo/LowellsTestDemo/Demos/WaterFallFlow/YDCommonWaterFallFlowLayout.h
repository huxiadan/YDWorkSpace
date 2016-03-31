//
//  YDCommonWaterFallFlowLayout.h
//  LowellsTestDemo
//
//  Created by lowell on 3/31/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDCommonWaterFallFlowLayout;

@protocol YDCommonWaterFallFlowLayoutDelegate <NSObject>

@required
- (CGFloat)waterFallFlowLayout:(YDCommonWaterFallFlowLayout *)layout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath;

@end

@interface YDCommonWaterFallFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<YDCommonWaterFallFlowLayoutDelegate> delegate;
@property (nonatomic, assign) NSInteger columnCount;//水平方向上有几列   defult: 2
@property (nonatomic, assign) CGFloat horizonalSpace;//item之间水平方向上的间隙
@property (nonatomic, assign) CGFloat verticalSpace;//item之间垂直方向的间隙
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

+ (instancetype)layoutWithColumnCount:(NSInteger)count horizonalSpace:(CGFloat)hSpace verticalSpace:(CGFloat)vSpace sectionInset:(UIEdgeInsets)sInset;

@end
