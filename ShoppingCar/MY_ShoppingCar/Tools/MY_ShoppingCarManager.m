//
//  MY_ShoppingCarManager.m
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import "MY_ShoppingCarManager.h"
#import "MY_ShoppingCarEndView.h"
#import "MY_ShoppingCarModel.h"
#import "MJExtension.h"

@interface MY_ShoppingCarManager () {
    id _target;
}

@property (nonatomic, strong) NSMutableArray *dataArray;    /**< 数据数组 */
@property (nonatomic, strong) NSMutableArray *selectArray;    /**< 模型数组 */

@end

@implementation MY_ShoppingCarManager

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

+ (instancetype)shareManager {
    static MY_ShoppingCarManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MY_ShoppingCarManager alloc] init];
    });
    return manager;
}

- (void)acquireDataWithType:(ShoppingCarType)type target:(id)target Success:(void (^)())success error:(void (^)())error{
    
    [self.dataArray removeAllObjects];
    [self.selectArray removeAllObjects];
#warning 请求网络数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shoppingCar" ofType:@"plist"];
    self.dataArray = [MY_ShoppingCarModel mj_objectArrayWithFile:plistPath];
    NSLog(@"%@",self.dataArray);
    success();
}

- (MY_ShoppingCarModel *)getTitleWithSection:(NSInteger)section {
    return self.dataArray[section];
}

- (Products *)getModelWithIndex:(NSIndexPath *)index {
    MY_ShoppingCarModel *shopModel = (MY_ShoppingCarModel *)[self.dataArray objectAtIndex:index.section];
    return [shopModel.products objectAtIndex:index.row];
}

- (NSInteger)getCurrentSection {
    return self.dataArray.count;
}

-(NSInteger)getCurrentRowWithSection:(NSInteger)section {
    
    MY_ShoppingCarModel *shopModel = (MY_ShoppingCarModel *)[self.dataArray objectAtIndex:section];
    return shopModel.products.count;
}

- (NSMutableArray *)getDataArray {
    return self.dataArray;
}

- (void)deleteDataWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView{
    MY_ShoppingCarModel *shopModel = [_dataArray objectAtIndex:indexPath.section];
    Products *goodsModel = shopModel.products[indexPath.row];
    [shopModel.products removeObject:goodsModel];
    if (shopModel.products.count == 0) {
        [_dataArray removeObject:shopModel];
        [_selectArray removeObject:shopModel];
    }
    [tableView reloadData];

}

- (void)didSelectSectionWithSection:(NSInteger)section senderSelect:(BOOL)selected{
    if (selected) {
        MY_ShoppingCarModel *shopModel = [_dataArray objectAtIndex:section];
        shopModel.select = NO;
        for (Products *goodsModel in shopModel.products) {
            goodsModel.select = NO;
            [_selectArray removeObject:shopModel];
        }
    } else {
        MY_ShoppingCarModel *shopModel = [_dataArray objectAtIndex:section];
        shopModel.select = YES;
        for (Products *goodsModel in shopModel.products) {
            goodsModel.select = YES;
            if (![_selectArray containsObject:shopModel]) {
                [_selectArray addObject:shopModel];
            }
        }
    }
    // 判断全选按钮是否激活
    int i = 0;
    for (MY_ShoppingCarModel *model in _dataArray) {
        if (!model.select) {
            i++;
        }
    }
    if (i == 0) {
        _endView.selectBtn.selected = YES;
    } else {
        _endView.selectBtn.selected = NO;
    }
}

- (void)didSelectCellWithIndexPath:(NSIndexPath *)indexPath senderSelect:(BOOL)selected{
    MY_ShoppingCarModel *shopModel = [_dataArray objectAtIndex:indexPath.section];
    Products *goodsModel = shopModel.products[indexPath.row];
    
    if (selected) {
        goodsModel.select = NO;
        int i = 0;
        for (Products *goodsModel in shopModel.products) {
            if (goodsModel.select) {
                i++;
            }
        }
        if (i == 0) {
            [_selectArray removeObject:shopModel];
        }
    } else {
        goodsModel.select = YES;
        if ([self.selectArray containsObject:shopModel]) {
            [self.selectArray removeObject:shopModel];
        }
        [self.selectArray addObject:shopModel];
    }
    
    // 创建一个变量记录商品是否都被点击
    int i = 0;
    // 遍历商品的选择状态
    for (Products *goodsModel in shopModel.products) {
        if (!goodsModel.select) {
            // 如果商品点击为NO，让变量变化
            i++;
        }
    }
    // 如果变量还是保持初始值，则商品都被点击
    if (i == 0) {
        shopModel.select = YES;
        [self didSelectSectionWithSection:indexPath.section senderSelect:NO];
    } else {
        shopModel.select = NO;
        _endView.selectBtn.selected = NO;
    }
}

- (void)didSelectAllBtn:(BOOL)selected {
    for (int i = 0; i < _dataArray.count; i ++) {
        [self didSelectSectionWithSection:i senderSelect:selected];
    }
}

- (NSMutableArray *)getSelectGoods {
    return _selectArray;
}

- (void)didSelectCellAddButtonWithIndexPath:(NSIndexPath *)indexPath success:(void (^)())success error:(void (^)())error{
    MY_ShoppingCarModel *shopModel = [_dataArray objectAtIndex:indexPath.section];
    __block Products *goodsModel = shopModel.products[indexPath.row];
    [self didSelectCellWithIndexPath:indexPath senderSelect:NO];
    goodsModel.productQty = (goodsModel.productQty + 1);
    if (goodsModel.productQty > 99) {
        goodsModel.productQty = 99;
    }
    if ([self.selectArray containsObject:shopModel]) {
        [self.selectArray removeObject:shopModel];
    }
    [self.selectArray addObject:shopModel];
    success();
}

- (void)didSelectCellSubtractButtonWithIndexPath:(NSIndexPath *)indexPath success:(void (^)())success error:(void (^)())error{
    MY_ShoppingCarModel *shopModel = [_dataArray objectAtIndex:indexPath.section];
    Products *goodsModel = shopModel.products[indexPath.row];
    [self didSelectCellWithIndexPath:indexPath senderSelect:NO];
    goodsModel.productQty = (goodsModel.productQty - 1);
    if (goodsModel.productQty < 1) {
        goodsModel.productQty = 1;
    }
    if ([self.selectArray containsObject:shopModel]) {
        [self.selectArray removeObject:shopModel];
    }
    [self.selectArray addObject:shopModel];
    success();
}

- (void)changeGoodsCountWithIndexPath:(NSIndexPath *)indexPath count:(int)count success:(void (^)())success error:(void (^)())error{
    MY_ShoppingCarModel *shopModel = [_dataArray objectAtIndex:indexPath.section];
    Products *goodsModel = shopModel.products[indexPath.row];
    [self didSelectCellWithIndexPath:indexPath senderSelect:NO];
    goodsModel.productQty = count;
    if ([_selectArray containsObject:shopModel]) {
        [_selectArray removeObject:shopModel];
    }
    [_selectArray addObject:shopModel];
    success();

}

@end
