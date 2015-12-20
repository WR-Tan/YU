//
//  SelectCityViewController.h
//  PANewToapAPP
//
//  Created by apple on 15/1/22.
//  Copyright (c) 2015年 Gavin. All rights reserved.
//

//#import "PAFF_TOAP_BaseViewController.h"
#import <UIKit/UIKit.h>

@class PAFFHaoHouseModel, PAFFCitysModel;

typedef void(^CityBlock)(PAFFCitysModel *);

@interface PAFFSelectCityViewController : UIViewController

@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *cityArray;
@property(nonatomic,strong)CityBlock  cityBlock;
@property(nonatomic, strong) PAFFHaoHouseModel * houseModel;
@property(nonatomic,strong)PAFFCitysModel *cityGPS;

@end

@interface PAFFCitysModel : NSObject
@property(nonatomic,strong)NSString *firstLetter;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *spell;
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString *lng;
@property(nonatomic,strong)NSString *subdistrictString;
- (id)initWithDic:(NSDictionary *)dic;
@end
