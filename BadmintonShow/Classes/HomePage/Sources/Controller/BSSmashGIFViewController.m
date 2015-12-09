//
//  BSSmashGIFViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/12/8.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSSmashGIFViewController.h"
#import "BSGameGIFCollectionViewCell.h"

@interface BSSmashGIFViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *gifArray;

@end

static NSString *cellIdentifer = @"SmashGIFCell";

@implementation BSSmashGIFViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self createCollectionView];
    
    [self createTempData];
}

- (void)createTempData
{
    for (NSInteger i = 0 ; i < 8;  i ++ ) {
        NSString *name = [NSString stringWithFormat:@"zhengshou_kousha_zhixian_%ld.gif",i+1];
        [self.gifArray addObject:name];
    }
    [self.collectionView reloadData];
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
    flowLayout.itemSize  =  CGSizeMake(kScreenWidth, 100);
    
    self.collectionView  = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
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
    return self.gifArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSGameGIFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];

    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (NSMutableArray *)gifArray{
    if (!_gifArray) {
        _gifArray = [ NSMutableArray array];
    }
    return _gifArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
