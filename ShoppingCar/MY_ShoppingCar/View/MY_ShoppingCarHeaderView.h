//
//  MY_ShoppingCarHeaderView.h
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MY_ShoppingCarModel.h"

@class MY_ShopModel;

@protocol MY_ShoppingCarHeaderViewDelegate <NSObject>

@optional
/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  分区头的选择按钮被点击
 */
- (void)shoppingCarHeaderViewSelectButtonClicked:(UIButton *)sender section:(NSInteger)section;

@end

@interface MY_ShoppingCarHeaderView : UIView

@property (nonatomic) id <MY_ShoppingCarHeaderViewDelegate> delegate; /**< 代理 */

@property (nonatomic, strong) MY_ShoppingCarModel *shopModel;    /**< 店铺数据 */

/**
 *  @author Mai, 16-01-20 17:01:58
 *
 *  获取分区头高度
 *
 *  @return 高度
 */
+ (CGFloat)getHeaderViewHeight;

@end
