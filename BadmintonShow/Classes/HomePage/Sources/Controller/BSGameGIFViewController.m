//
//  BSGameGIFViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/12/7.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSGameGIFViewController.h"
#import "BSGameGIFCollectionViewCell.h"

@interface BSGameGIFViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end


static NSString *cellIdentifer   = @"GameGIFCell";

@implementation BSGameGIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)createCollectionView
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    flowLayout.footerReferenceSize = CGSizeMake(kScreenWidth, 50);
    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 50);
    flowLayout.minimumLineSpacing  = 10;
    flowLayout.minimumInteritemSpacing  = 10;
//    flowLayout.sectionInset              = UIEdgeInsetsZero;
    flowLayout.itemSize  =  CGSizeMake(50, 50);
    
    self.collectionView  = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    [self.view addSubview:self.collectionView];
    
    [ self.collectionView registerClass:[BSGameGIFCollectionViewCell class]
         forCellWithReuseIdentifier:cellIdentifer];
    
}


#pragma mark - CollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSGameGIFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer
                                                                       forIndexPath:indexPath];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
