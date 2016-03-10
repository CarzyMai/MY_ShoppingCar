//
//  MY_ShoppingCarCell.h
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MY_ShoppingCarModel.h"
#import "MY_ShoppingCarChangeNumberView.h"


/**
 *  @author Mai, 16-01-20 17:01:55
 *
 *  购物车代理方法
 */
@protocol MY_ShoppingCarCellDelegate <NSObject>
// 可选
@optional
/**
 *  @author Mai, 16-01-20 17:01:51
 *
 *  购物车Cell上的选择按钮被点击
 */
- (void)shoppingCarCellSelectButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;

/**
 *  @author Mai, 16-01-20 17:01:20
 *
 *  购物车Cell上的删除按钮被点击
 */
- (void)shoppingCarCellDeleteButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量加按钮被点击
 */
- (void)shoppingCarCellAddButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量减按钮被点击
 */
- (void)shoppingCarCellSubtractButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量text修改
 */
- (void)shoppingCarCellChangeCountText:(NSString *)text indexPath:(NSIndexPath *)indexPath;


@end

@interface MY_ShoppingCarCell : UITableViewCell

/**
 *  @author Mai, 16-01-16 10:01:33
 *
 *  内部初始化方法
 *
 *  @param tableView 当前显示的tableview
 *
 *  @return 返回cell
 */
+ (MY_ShoppingCarCell *)shoppingCarCellWithTableView:(UITableView *)tableView;

/**
 *  @author Mai, 16-01-16 10:01:58
 *
 *  获取cell高度
 *
 *  @return 返回高度
 */
+ (CGFloat)getCellHeight;

@property (nonatomic, strong) Products *model;    /**< model */
@property (nonatomic) id <MY_ShoppingCarCellDelegate> delegate;   /**< 代理 */
@property (nonatomic, strong) NSIndexPath *indexPath;    /**< cell的位置 */
@property (nonatomic, strong) UIButton *selectBtn;    /**< 选择按钮 */
@property (nonatomic, strong) UIImageView *productImg;    /**< 商品图片 */
@property (nonatomic, strong) UILabel *productNameLab;    /**< 商品名称 */
@property (nonatomic, strong) UILabel *sizeLab;    /**< 商品规格 */
@property (nonatomic, strong) UILabel *costPriceLab;    /**< 商品原价 */
@property (nonatomic, strong) UILabel *currentPriceLab;    /**< 商品现价 */
@property (nonatomic, strong) UIButton *deleteButton;    /**< 删除按钮 */
@property (nonatomic, strong) MY_ShoppingCarChangeNumberView *changeView;    /**< 改变数量的视图 */

@end
