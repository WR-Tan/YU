//
//  CNCityPickerView.m
//  CNCityPickerView
//
//  Created by 伟明 毕 on 15/3/25.
//  Copyright (c) 2015年 Weiming Bi. All rights reserved.
//

#import "CNCityPickerView.h"

@interface CNCityPickerView()  <UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView *_pickerView;
    NSArray *_dataArray;
    NSArray *_cityArray;
    NSArray *_areaArray;
    
    NSString *_province;
    NSString *_city;
    NSString *_area;
}

@end

@implementation CNCityPickerView

- (id)initWithframe:(CGRect)frame didSelected:(void (^)(NSString *province, NSString *city, NSString *area))finishBlock {
    self.hasScroll = NO;
    self.finishBlock = finishBlock;
    
    self = [self initWithFrame:frame];
    [self p_init];
    return self;
    
}

//设置返回的数据
-(void)fetchBackString{
    self.backString = [NSString stringWithFormat:@"%@ %@ %@",_province, _city?:@"", _area?:@""];
}




- (instancetype)init {
    NSAssert(NO, @"fail, using initWithFrame:");
    return nil;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
////        [self p_init];
//    }
//    return self;
//}

- (void)awakeFromNib {
    [self p_init];
    
    _pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pickerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pickerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pickerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pickerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self setNeedsLayout];
}

- (void)p_init {
    _rowHeight = 24.0f;
    CGRect frame = self.frame;
    frame.size.height = 216; //180.0f;
    self.frame = frame;
 
    
    _dataArray = [self getAddressArray];
    CNCityAddressModel *firstAreaModel = [_dataArray firstObject];
    _cityArray = firstAreaModel.sub;
    
    CNCityAddresCitiesModel *firstCitiesModel = [_cityArray firstObject];
    _areaArray = firstCitiesModel.sub;
    
    _province = firstAreaModel.name;
    _city = firstCitiesModel.name;
    _area = [_areaArray firstObject];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    
    self.backgroundColor = [UIColor whiteColor];
}


-  (NSArray *)getAddressArray {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *addrssArray = dict[@"address"];
    
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    [addrssArray enumerateObjectsUsingBlock:^(NSDictionary* item, NSUInteger idx, BOOL *stop) {
        CNCityAddressModel *model = [[CNCityAddressModel alloc] initWithDictionary:item];
        [arrM addObject:model];
    }];
    
    return arrM;
}


+ (instancetype)createPickerViewWithFrame:(CGRect)frame valueChangedCallback:(void (^)(NSString *, NSString *, NSString *))valueChangedCallback {
    CNCityPickerView *pickerView = [[CNCityPickerView alloc] initWithFrame:frame];
    [pickerView setValueChangedCallback:valueChangedCallback];
    return pickerView;
}

#pragma mark- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger number = 0;
    switch (component) {
        case 0:
            number = _dataArray.count;
            break;
            
        case 1:
            number = _cityArray.count;
            break;
        case 2:
            number = _areaArray.count;
            break;
    }
    return number;
}

#pragma mark- UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return _rowHeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (0 == component) {
        CNCityAddressModel *areaModel = _dataArray[row];
        _cityArray = areaModel.sub;
        CNCityAddresCitiesModel *citiesModel = [_cityArray firstObject];
        _areaArray = citiesModel.sub;
        
        _province = areaModel.name;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        _city = citiesModel.name;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        _area = [_areaArray firstObject];
        
    } else if (1 == component) {
        if (_cityArray.count > 0) {
            CNCityAddresCitiesModel *citiesModel = _cityArray[row];
            _areaArray = citiesModel.sub;
            
            if (![citiesModel.name isEqualToString:_city]) {
                _city = citiesModel.name;
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
            }
            
            _area = [_areaArray firstObject];
        }
    } else if (2 == component) {
        _area = _areaArray[row];
    }
    [self p_display];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSMutableAttributedString *title = nil;
    if (0 == component) {
        CNCityAddressModel *areaModel = _dataArray[row];
        title = [[NSMutableAttributedString alloc] initWithString:areaModel.name];
    } else if (1 == component) {
        CNCityAddresCitiesModel *areaCitiesModel = _cityArray[row];
        title = [[NSMutableAttributedString alloc] initWithString:areaCitiesModel.name];
    } else if (2 == component) {
        title = [[NSMutableAttributedString alloc] initWithString:_areaArray[row]];
    }
    
    if (_textAttributes) {
        [title addAttributes:_textAttributes range:NSMakeRange(0, title.string.length)];
    }

    
    UILabel *label = nil;
    if (view) {
        label = (UILabel *)view;
    } else {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:17.0f];
    }
    label.attributedText = title;
    
    view = label;
    return view;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat width = 0.0f;
    switch (component) {
        case 0: width = pickerView.bounds.size.width * 0.3;  break;
        case 1: width = pickerView.bounds.size.width * 0.3;  break;
        case 2: width = pickerView.bounds.size.width * 0.4;
        default:
            break;
    }
    return width;
}

#pragma mark- Override Methods
- (void)setValueChangedCallback:(void (^)(NSString *, NSString *, NSString *))valueChangedCallback {
    _valueChangedCallback = [valueChangedCallback copy];
    [self p_display];
}

#pragma mark- Other Methods
- (void)p_display {
    _city = _city == nil ? @"" : _city;
    _area = _area == nil ? @"" : _area;
    if (_valueChangedCallback) _valueChangedCallback(_province, _city, _area);
}


@end








#pragma mark - Address
///========================================================================
/// @name Address
///========================================================================


@implementation CNCityAddressModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        NSMutableArray *areaCitiesArray = [[NSMutableArray alloc] init];
        [dictionary[@"sub"] enumerateObjectsUsingBlock:^(NSDictionary* dict, NSUInteger idx, BOOL *stop) {
            CNCityAddresCitiesModel *areaCitiesModel = [[CNCityAddresCitiesModel alloc] initWithDictionary:dict];
            [areaCitiesArray addObject:areaCitiesModel];
        }];
        self.sub = areaCitiesArray;
        self.name = dictionary[@"name"];
    }
    return self;
}
@end

@implementation CNCityAddresCitiesModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if(dictionary[@"name"]) self.name = dictionary[@"name"] ;
        if (dictionary[@"sub"]) self.sub = dictionary[@"sub"] ;
    }
    return self;
}
@end
