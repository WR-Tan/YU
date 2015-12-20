//
//  SelectCityViewController.m
//  PANewToapAPP
//
//  Created by apple on 15/1/22.
//  Copyright (c) 2015年 Gavin. All rights reserved.
//

// Controller
#import "PAFFSelectCityViewController.h"

// Bussiness
//#import "PAFFHouseBussiness.h"
//#import "PAFFCommonFunc.h"
//
//// Other
//#import "PAFFGPSManager.h"
//#import <PAFFNetErrorCode.h>
//#import "CLLocation+Sino.h"

#pragma mark - CityModel 城市模型
///========================================================================
/// @name CityModel 城市模型
///========================================================================
@implementation PAFFCitysModel
- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.firstLetter = [dic objectForKey:@"firstLetter"];
        self.lat         = [dic objectForKey:@"lat"];
        self.lng         = [dic objectForKey:@"lng"];
        self.name        = [dic objectForKey:@"name"];
        self.spell       = [dic objectForKey:@"spell"];
    }
    return self;
}
@end

#pragma mark - PAFFSelectCityViewController 选择城市
///========================================================================
/// @name PAFFSelectCityViewController 选择城市
///========================================================================

@interface PAFFSelectCityViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate/*PAFFGPSManagerDelegate*/>
{
    NSMutableDictionary         *_cityDic;
    NSMutableArray              *_searchNameArray;
    NSMutableArray              *_searchEenglingNameArray;
    NSArray                     *_searchArray;
    NSArray                     *_searchEnglingArray;
    NSMutableArray              *_cityEngNameArray;
    UISearchDisplayController   *searchDisplayController;
    UIView                      *_heardView;
    UILabel                     *_cityNameLab;
    NSArray                     *_secArr;
    NSArray                     *_keyArray;
    UILabel                     *labelGPS;
    NSString                    *_stringGPS;
}

@end

static NSString *headCellId = @"myheadcell";
static NSString *cellId = @"mycell";

@implementation PAFFSelectCityViewController

#pragma mark- <生命周期>
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"切换城市";
    _searchEenglingNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    _cityEngNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [self initSubViews];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self startLocation];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [[PAFFGPSManager shareInstance] stopLocation];
//}
//
//-(void)startLocation{
//    PAFFGPSManager * manager =[PAFFGPSManager shareInstance];
//    manager.delegate = self;
//    [manager startLocation];
//}

#pragma mark- <界面相关>
- (void)initSubViews
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    searchBar.placeholder = @"请输入城市名称或城市首字母";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,44, kScreenWidth, kScreenHeight- 64 - 44) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kBackgroudColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // 并把 searchDisplayController 和当前 controller 关联起来
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    _secArr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
    _cityDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    _keyArray = nil;
    
    _cityArray = [[NSMutableArray alloc]initWithCapacity:0];
    _searchNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    _stringGPS = @"GPS正在定位中";
    [self getCityList];
}

#pragma mark - <Delegate>
#pragma mark -- UITableViewSourceDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return _keyArray.count + 1;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        if(section == 0)
        {
            return 1;
        }
        else{
            return [[_cityDic objectForKey:_keyArray[section-1]] count];
        }
    }
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchDisplayController.searchBar.text];
        _searchArray =  [[NSArray alloc] initWithArray:[_searchNameArray filteredArrayUsingPredicate:predicate]];
        _searchEnglingArray = [[NSArray alloc] initWithArray:[_searchEenglingNameArray filteredArrayUsingPredicate:predicate]];
        if (_searchArray.count> 0 )
        {
            return _searchArray.count;
        }
        else
        {
            return _searchEnglingArray.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
        if(indexPath.section == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headCellId];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
                lineLab.backgroundColor = [UIColor colorWithRed:213/255. green:213/255. blue:213/255. alpha:0.8];
                [cell addSubview:lineLab];
                UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 49.5, kScreenWidth, 0.5)];
                lineLabel.backgroundColor = [UIColor colorWithRed:213/255. green:213/255. blue:213/255. alpha:0.8];
                [cell addSubview:lineLabel];
                _heardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 80)];
                _cityNameLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 60, 30)];
                _cityNameLab.textAlignment = NSTextAlignmentCenter;
                _cityNameLab.font = kBSFontSize(14);
                _cityNameLab.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
                [_heardView addSubview:_cityNameLab];
                
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 10, 10)];
                imageView.image = [UIImage imageNamed:@"changeGPSCity"];
                [_heardView addSubview:imageView];
                
                labelGPS = [[UILabel alloc]initWithFrame:CGRectMake(95, 10, 200, 30)];
                labelGPS.font = kBSFontSize(14);
                labelGPS.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
                [_heardView addSubview:labelGPS];
                
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50,tableView.frame.size.width, 30)];
                lab.text = @"   选择城市";
                lab.backgroundColor = [UIColor colorWithRed:246/255. green:248/255. blue:254/255. alpha:1];
                lab.font = kBSFontSize(14);
                lab.textColor = [UIColor colorWithRed:170/255. green:170/255. blue:170/255. alpha:1];
                [_heardView addSubview:lab];
                
                [cell addSubview:_heardView];
            }
            _cityNameLab.text = self.cityGPS.name;
            labelGPS.text = _stringGPS;
            return cell;
        }
        else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            NSMutableArray *array = [_cityDic objectForKey:_keyArray[indexPath.section - 1]];
            PAFFCitysModel *city = array[indexPath.row];
            cell.textLabel.text = city.name;
            cell.textLabel.font = kBSFontSize(14);
            cell.textLabel.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
            return cell;
        }
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (_searchEnglingArray.count > 0)
        {
            [_cityEngNameArray removeAllObjects];
            NSString *englingStr = _searchEnglingArray[indexPath.row];
            for (PAFFCitysModel *model in _cityArray)
            {
                if ([model.firstLetter isEqualToString:englingStr])
                {
                    [_cityEngNameArray addObject:model];
                }
            }
        }
        if (_cityEngNameArray.count > 0)
        {
            PAFFCitysModel *model = _cityEngNameArray[indexPath.row];
            cell.textLabel.text = model.name;
        }
        else
        {
            if (_searchArray.count > 0)
            {
                cell.textLabel.text = _searchArray[indexPath.row];
            }
        }
        cell.textLabel.font = kBSFontSize(14);
        cell.textLabel.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tableView)
    {
        if(section > 0)
        {
            return [_secArr objectAtIndex:section -1];
        }
        else{
            return nil;
        }
    }
    else {
        return nil;
    }
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _secArr;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (tableView == self.tableView) ?
    (indexPath.section == 0 ? 80 : 40 ) : 40 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.01 : 30 ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tableView) {
        if(section == 0) {
            return nil;
        } else {
            UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 30)];
            titleView.backgroundColor = [UIColor colorWithRed:248/255. green:250/255. blue:254/255. alpha:1];
            NSString * secTitle = [_secArr objectAtIndex:(section-1)];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
            label.text = secTitle;
            label.textColor = [UIColor colorWithRed:170/255. green:170/255. blue:170/255. alpha:0.8];
            
            UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
            lineLab.backgroundColor = [UIColor colorWithRed:213/255. green:213/255. blue:213/255. alpha:0.8];
            [titleView addSubview:lineLab];
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 29.5, kScreenWidth, 0.5)];
            lineLabel.backgroundColor = [UIColor colorWithRed:213/255. green:213/255. blue:213/255. alpha:0.8];
            [titleView addSubview:lineLabel];
            
            [titleView addSubview:label];
            
            return titleView;
        }
    } else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark -- UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
}

#pragma mark -- POGPSManagerDelegate
-(void)successGetLocation:(CLLocationCoordinate2D)coordinate{
    //添加房查找附近的小区,坐标需转换为BD09
    // 解析地址，刷新tableView
}

-(void)failGetLocation:(NSString*)errorMsg{
    
    _stringGPS = errorMsg;
    [self.tableView reloadData];
    // 显示定位失败警告
}

#pragma mark - <Network>
//城市列表
- (void)getCityList {
    NSDictionary *value;
    
    NSArray *array = value[@"cityList"];
    if(_keyArray == nil) {
        _keyArray = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
        for (int i = 0; i < _keyArray.count; i ++) {
            NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
            [_cityDic setObject:array forKey:[NSString stringWithFormat:@"%@",_keyArray[i]]];
        }
    }
    
    for (int i = 0; i < array.count; i ++) {
        PAFFCitysModel *city = [PAFFCitysModel modelWithDictionary:array[i]];
        [_cityArray addObject:city];
        [_searchNameArray addObject:city.name];
        [_searchEenglingNameArray addObject:city.firstLetter];
    }
    
    if (self.cityArray.count > 0) {
        for (int i = 0; i < self.cityArray.count; i ++){
            PAFFCitysModel *city = self.cityArray[i];
            [[_cityDic objectForKey:city.firstLetter] addObject:city];
        }
        [self.tableView reloadData];
    }
    
    
}

@end
