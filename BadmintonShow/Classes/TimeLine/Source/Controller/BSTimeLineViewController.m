//
//  BSTimeLineViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/12/11.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSTimeLineViewController.h"
#import "AVQuery.h"
#import "BSTLModel.h"
#import "YYTableView.h"
#import "YYKit.h"
#import "T1StatusCell.h"
#import "BSStatusCell.h"
#import "YYPhotoGroupView.h"


@interface BSTimeLineViewController ()
<UITableViewDelegate,UITableViewDataSource,
BSStatusCellDelegate,T1StatusCellDelegate>
@property (nonatomic, strong) NSMutableArray *layouts;
@end

@implementation BSTimeLineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _layouts = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
    
    AVQuery *quer = [AVQuery queryWithClassName:@"Status"];
    [quer includeKey:@"pics"];
    [quer includeKey:@"user"];
    [quer findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        AVObject *status = objects[0];
//        BSTLModel *tlModel = [BSTLModel modelWithAVObject:status];
//        BSTLModel *tweet = tlModel;
//        BSTLLayout *layout = [BSTLLayout new];
//        layout.tweet = tweet;
//        [_layouts addObject:layout];
//        [self.tableView reloadData];
        
        BSTLModel *model = [[BSTLModel alloc] init];
        model.objectId = @"wejfalasdfjkxzivsi";
        model.createdAt = [NSDate date];
        model.updatedAt = [NSDate date];
        
        BSProfileUserModel *user = [[BSProfileUserModel alloc] init];
        user.avatarUrl = @"www.baidu.com.s";
        user.userName = @"swelzh";
        user.nickName = @"李智华";
        model.user = user;
        
        model.text = @"[开心]这是一条moo☹️😙c数据流口水的减肥啊；老师的咖啡机阿里；可视对讲发了；收快递费骄傲；了深刻的减肥阿里山；快点放假阿拉善；快点放假阿☹️😙里；深刻的减肥啊；了深刻的减肥啊；了深刻的减肥；阿里山的风☹️😙景啊；了SD卡积☹️😙分啊；老师的咖啡机啊；了深刻的风景啊；了深刻的风景啊；了深刻的风景阿隆索；快点放假阿里；上刊登激发了；深刻的风景阿勒斯；快点放假阿莱士；宽度附近阿嫂；离开的房☹️😙间 www.baidu.com";
        model.favoriteCount = 2009;
        model.commentsCount = 3010;
        NSMutableArray *picM = [NSMutableArray array];
        for (NSInteger i = 0;i < 4; i++ ) {
            BSTLMedia *picModel = [[BSTLMedia alloc] init ];
            picModel.url = [NSURL URLWithString:@"http://ac-6ruurxeo.clouddn.com/iueeuuMLyCnCeE699fQ3PRC"];
//@"http://b.hiphotos.baidu.com/image/h%3D200/sign=234bd32e09d79123ffe093749d355917/0823dd54564e925838c205c89982d158ccbf4e26.jpg"
            
            if (picModel) {
                [picM addObject:picModel];
            }
        }
        model.medias = picM;
 
        BSStatusLayout *layout = [[BSStatusLayout alloc] initWithStatus:model style:BSLayoutStyleTimeline];
        [layout layout];
        [_layouts addObject:layout];
     
     
        [self.tableView reloadData];
    }];
    
}
 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _layouts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((BSTLLayout *)_layouts[indexPath.row]).height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    BSStatusCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[BSStatusCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.delegate = self;
    }
    [cell setLayout:_layouts[indexPath.row]];
    return cell;
}




/// 点击了图片
- (void)cell:(BSStatusCell *)cell didClickImageAtIndex:(NSUInteger)index {
    UIImageView *fromView = nil;
    NSMutableArray *items = [NSMutableArray new];
    BSTLModel *status = cell.statusView.layout.status;
    NSArray *pics = status.medias;
    
    for (NSUInteger i = 0, max = pics.count; i < max; i++) {
        UIImageView *imgView = cell.statusView.picViews[i];
        BSPicture *pic = pics[i];
//        BSPictureMetadata *meta = pic.largest.badgeType == BSPictureBadgeTypeGIF ? pic.largest : pic.large;
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = imgView;
//        item.largeImageURL = meta.url;
//        item.largeImageSize = CGSizeMake(meta.width, meta.height);
        [items addObject:item];
        if (i == index) {
            fromView = imgView;
        }
    }
    
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    [v presentFromImageView:fromView toContainer:self.navigationController.view animated:YES completion:nil];
}



@end
