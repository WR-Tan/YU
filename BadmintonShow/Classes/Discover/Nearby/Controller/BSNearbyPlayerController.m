//
//  BSNearbyPeopleController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/30.
//  Copyright (c) 2015年 LZH. All rights reserved.
//  附近的人

#import "BSNearbyPlayerController.h"
#import "BSNearbyPlayerCell.h"

@interface BSNearbyPlayerController () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}
@end

@implementation BSNearbyPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addCollectionView];
}


#pragma mark - 界面初始化

#pragma mark 1.添加CollectionView
- (void)addCollectionView
{
    //  1.布局
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //  2.初始化CollectionView
    CGSize size = self.view.bounds.size;
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 64) collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.userInteractionEnabled = YES;
    _collectionView.scrollEnabled = YES;
    
    [_collectionView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
    self.view.userInteractionEnabled = YES;
    //注册Cell，必须要有
    [_collectionView registerNib:[UINib nibWithNibName:@"BSNearbyPlayerCell" bundle:nil] forCellWithReuseIdentifier:@"BSNearbyPlayerCell"];
    
    [self.view addSubview:_collectionView];

}


#pragma mark -- UICollectionViewDataSource 数据源方法

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 30;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"BSNearbyPlayerCell";
    BSNearbyPlayerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout 布局

#pragma mark  定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake(145, 145);
    return CGSizeMake(300, 120);
}

#pragma mark  定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma mark - UICollectionViewDelegate  代理方法
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
