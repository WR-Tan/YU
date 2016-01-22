//
//  BSConfirmGameTableViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/11/20.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSConfirmGameTableViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "BSConfirmGameCell.h"
#import "SVProgressHUD.h"
#import "ELORankingBusiness.h"
#import "BSGameModel.h"
#import "MJRefresh.h"
#import "BSRankController.h"

static NSString *cellId = @"BSConfirmGameCellId";


@interface BSConfirmGameTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView ;

@property (nonatomic, strong) AVObject *gameObject; // 已经上传的game

@property (nonatomic, strong) AVUser *oppUser;

@property (nonatomic, strong) BSGameModel *myGame;  // 已经上传的game

@property (nonatomic, strong) UIButton * confirmBtn;


@end

#define kNullLongText   @"----"
#define kNullShortText  @"--"

@implementation BSConfirmGameTableViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        _oppUser = [AVUser user];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBaseViews];
    [self initData];
}

- (void)setupBaseViews{
    self.title = @"确认比赛结果";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSConfirmGameCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [self initData];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAction:)];
    
    
//    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    confirmBtn.frame = CGRectMake(0, kScreenHeigth - 44 , kScreenWidth, 44);
//    [confirmBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
//    [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:confirmBtn];
//    self.confirmBtn = confirmBtn;
//    [self modifyConfirmButtonWith:NO];
}

- (void)initData {
    [SVProgressHUD show];
    AVQuery *query = [AVQuery queryWithClassName:AVClassGame];
    [query whereKey:AVPropertyObjectId equalTo:self.gameObjectId];
    [query includeKey:AVPropertyAPlayer];
    [query includeKey:AVPropertyBPlayer];
    [query includeKey:AVPropertyCreator];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取比赛结果失败,请检查网络"];
            return ;
        }
        if (!objects.count) {
            [SVProgressHUD showErrorWithStatus:@"获取比赛结果失败"];
            return ;
        }
        
        [SVProgressHUD dismiss];
        self.myGame = [BSGameModel modelWithAVObject:objects[0]];
        self.oppUser.objectId = self.myGame.bPlayer.objectId;
        self.gameObject = objects[0];
        
        BOOL isSelf = [[self.gameObject[AVPropertyCreator] objectId] isEqualToString:AppContext.user.objectId];
        if (isSelf) {
            [self modifyConfirmButtonWith:YES ];
        }else {
            BOOL isConfirmed = [self.gameObject[AVPropertyIsConfirmed] boolValue];
            [self modifyConfirmButtonWith:isConfirmed];
        }

        [self.tableView reloadData];
    }];
 
}

- (void)modifyConfirmButtonWith:(BOOL)confirmed{
    UIColor *buttonColor = confirmed ? [UIColor lightGrayColor] : [UIColor blueColor];
    [self.confirmBtn setBackgroundColor:buttonColor];
    self.confirmBtn.enabled = !confirmed;
    self.confirmBtn.hidden = NO;
}


#pragma mark - IBAction
- (void)confirmAction:(id)sender{
    
    //  1.如果比赛还未被加载！
    if (!self.gameObject) {
        [SVProgressHUD showInfoWithStatus:@"比赛数据尚未加载，请检查网络"];
        return;
    }
    
    //  2.如果比赛已经被确认！
    if ( self.myGame.isConfirmed ) {
        [SVProgressHUD showInfoWithStatus:@"你已经确认比赛了"];
        return;
    }
    
    //  1.修改 Game的isConfirmed属性为YES
    [self.gameObject setObject:@YES forKey:AVPropertyIsConfirmed];
    [self.gameObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
       
        [self modifyConfirmButtonWith:succeeded];
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"确认比赛错误"];
            [self.gameObject setObject:@NO forKey:AVPropertyIsConfirmed];
            return ;
        }
        
        if (succeeded) {
            [SVProgressHUD showSuccessWithStatus:@"确认比赛成功"];
            self.myGame.isConfirmed = YES ;

            [self.tableView reloadData];
            [self debugMessage];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationKeyUserUpdated object:nil];
        }
    }];
}

- (void)debugMessage
{
    NSInteger aBeforeScore = self.myGame.aPlayer.score;
    NSInteger bBeforeScore = self.myGame.bPlayer.score;
    
    [[AVUser currentUser] fetchInBackgroundWithKeys:@[@"score"]  block:^(AVObject *object, NSError *error) {
       
        [self.oppUser fetchInBackgroundWithKeys:@[@"score"]  block:^(AVObject *object, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            
            
            
            NSInteger myAfterScore = [(NSNumber *)[AVUser currentUser][@"score"] integerValue];
            NSInteger oppAfterScore = [(NSNumber *)self.oppUser[@"score"] integerValue];
            
            NSString *beforeMessage = [NSString stringWithFormat:@"我：%ld -> %ld",(long)aBeforeScore, (long)myAfterScore];
            
            NSString *afterMessage = [NSString stringWithFormat:@"%@：%ld -> %ld",
                                      self.myGame.bPlayer.userName,(long)bBeforeScore ,(long)oppAfterScore];
            NSString *message = [NSString stringWithFormat:@"%@\n%@",beforeMessage,afterMessage];
//            
//            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"比赛结果:" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
        }];
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   UINavigationController *rankNav = self.tabBarController.viewControllers[0];
    BSRankController *vc = rankNav.viewControllers[0];
    [vc updateUser];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BSConfirmGameCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    // Configure the cell...
    cell.beginTimeLabel.text = self.myGame.startTime ? : @" ";
    cell.aNameLabel.text = self.myGame.aPlayer.userName ?: @" ";
    cell.bNameLabel.text = self.myGame.bPlayer.userName ?: @" ";
    
    cell.aScoreLabel.text = self.myGame.aScore ?: @" ";
    cell.bScoreLabel.text = self.myGame.bScore ?: @" ";
    
    [cell.aAvatarImageView setImageWithURL:[NSURL URLWithString:self.myGame.aPlayer.avatarUrl] placeholder:kImageUserAvatar];
    [cell.bAvatarImageView setImageWithURL:[NSURL URLWithString:self.myGame.bPlayer.avatarUrl] placeholder:kImageUserAvatar];

    cell.confirmImageView.hidden = !self.myGame.isConfirmed;
    BOOL isAWinner =  [self.myGame.aScore integerValue] >     [self.myGame.bScore integerValue];
    

    BOOL shouldBeRed  = isAWinner || !self.myGame.aScore;
    
    
    cell.resultLabel.text = [NSString stringWithFormat:@"%@",shouldBeRed? @"胜利" : @"失败"];
    cell.resultLabel.backgroundColor = shouldBeRed ? [UIColor redColor] : [UIColor greenColor];
    cell.resultLabel.textColor = shouldBeRed ? [UIColor whiteColor]:[UIColor blackColor];
    cell.resultLabel.layer.cornerRadius = 2.0f;

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 252;
}




@end
