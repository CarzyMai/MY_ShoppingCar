//
//  MY_ShoppingCarManager.h
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MY_ShoppingCarModel.h"

@class MY_ShoppingCarEndView;

typedef NS_ENUM(NSInteger, ShoppingCarType) {
    ShoppingCarTypeTTT ,
    ShoppingCarTypeMall
};

@interface MY_ShoppingCarManager : NSObject

@property (nonatomic) ShoppingCarType carType;

@property (nonatomic, strong) MY_ShoppingCarEndView *endView;    /**< <#name#> */

/**
 *  @author Mai, 16-01-21 16:01:58
 *
 *  单例
 *
 *  @return 单例
 */
+ (instancetype)shareManager;

/**
 *  @author Mai, 16-01-12 13:01:13
 *
 *
 */
/**
 *  @author Mai, 16-03-04 11:03:21
 *
 *  请求购物车列表
 *
 *  @param type    购物车商城类型
 *  @param success 请求成功（有数据）
 *  @param error   请求成功（无数据）
 */
- (void)acquireDataWithType:(ShoppingCarType)type target:(id)target Success:(void (^)())success error:(void (^)())error;

/**
 *  @author Mai, 16-01-12 13:01:19
 *
 *  获取商品model
 *
 *  @param index 根据当前的indexPath
 *
 *  @return 返回对应的商品model数据
 */
- (Products *)getModelWithIndex:(NSIndexPath *)index;

/**
 *  @author Mai, 16-01-21 16:01:21
 *
 *  获取分区数
 *
 *  @return 获取分区数
 */
- (NSInteger)getCurrentSection;

/**
 *  @author Mai, 16-01-21 16:01:32
 *
 *  获取对应分区的行数
 *
 *  @param section 分区
 *
 *  @return 获取对应分区的行数
 */
- (NSInteger)getCurrentRowWithSection:(NSInteger)section;

/**
 *  @author Mai, 16-01-21 16:01:56
 *
 *  获取分区数据
 *
 *  @param section 分区
 *
 *  @return 获取分区标题
 */
- (MY_ShoppingCarModel *)getTitleWithSection:(NSInteger)section;

/**
 *  @author Mai, 16-01-21 16:01:11
 *
 *  获取购物车列表数据
 *
 *  @return 购物车列表数据（MY_ShoppingCarModel）数组
 */
- (NSMutableArray *)getDataArray;

/**
 *  @author Mai, 16-01-21 16:01:24
 *
 *  根据IndexPath删除对应的商品数据
 */
- (void)deleteDataWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

/**
 *  @author Mai, 16-01-21 15:01:47
 *
 *  分区头选择按钮点击时使其分组的元素变化
 */
- (void)didSelectSectionWithSection:(NSInteger)section senderSelect:(BOOL)selected;

/**
 *  @author Mai, 16-01-21 15:01:47
 *
 *  Cell选择按钮点击时使其分组的元素变化
 */
- (void)didSelectCellWithIndexPath:(NSIndexPath *)indexPath senderSelect:(BOOL)selected;

/**
 *  @author Mai, 16-02-26 10:02:50
 *
 *  全选按钮点击
 */
- (void)didSelectAllBtn:(BOOL)selected;

/**
 *  @author Mai, 16-02-26 11:02:54
 *
 *  获取被选中的商品（MY_ShoppingCarModel）数组
 */
- (NSMutableArray *)getSelectGoods;

/**
 *  @author Mai, 16-01-21 15:01:47
 *
 *  Cell上数量加
 */
- (void)didSelectCellAddButtonWithIndexPath:(NSIndexPath *)indexPath success:(void (^)())success error:(void (^)())error;

/**
 *  @author Mai, 16-01-21 15:01:47
 *
 *  Cell上数量减
 */
- (void)didSelectCellSubtractButtonWithIndexPath:(NSIndexPath *)indexPath success:(void (^)())success error:(void (^)())error;

/**
 *  改变购买数量
 */
- (void)changeGoodsCountWithIndexPath:(NSIndexPath *)indexPath count:(int)count success:(void (^)())success error:(void (^)())error;

@end
