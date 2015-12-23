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

static NSString *cellId = @"BSConfirmGameCellId";


@interface BSConfirmGameTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView ;

@property (nonatomic, strong) AVObject *gameObject; // 已经上传的game

@property (nonatomic, strong) AVUser *oppUser;

@property (nonatomic, strong) BSGameModel *myGame;  // 已经上传的game

@property (nonatomic, assign) BOOL isGameLoaded;
@property (nonatomic, assign) BOOL isAScoreSetted;
@property (nonatomic, assign) BOOL isBScoreSetted;
@property (nonatomic, assign) BOOL isBothScoreSetted;

@property (nonatomic, strong) UIButton * confirmBtn;


@end

#define kNullLongText   @"----"
#define kNullShortText  @"--"

@implementation BSConfirmGameTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _myGame = [[BSGameModel alloc] init];
        _isGameLoaded = NO;
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
 



- (void)setupBaseViews
{
     self.title = @"确认比赛结果";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSConfirmGameCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(0, kScreenHeigth - 44 , kScreenWidth, 44);
    [confirmBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor lightGrayColor];
    [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
}

- (void)initData
{
    AVObject *game = [AVObject objectWithoutDataWithClassName:AVClassGame objectId:self.gameObjectId];

    [game fetchInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        //  1.处理错误：
        if (error) {
            NSString *errorMsg = [ NSString stringWithFormat:@"获取比赛结果失败,%@",error];
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return ;
        }
        
        //  2.成功：
        [self completeGameModelWithObject:object block:^{
            
            self.isGameLoaded = YES ;
            
            
            //  刷新界面
            [self.tableView reloadData];
        }];
    }];
}


//  获取Game中_User的完整信息！
- (void)completeGameModelWithObject:(AVObject *)game  block:( void (^) (void) )block{
    self.gameObject = game;
    
    //  1.取出比赛双方
    
    BOOL isAPlayerSelf = [game[@"aPlayer"][@"objectId"] isEqualToString:[AVUser currentUser].objectId];
    if (isAPlayerSelf) {
        self.oppUser = game[@"bPlayer"];
    }else{
        self.oppUser = game[@"aPlayer"];
    }
    
    _myGame.isConfirmed = [game[@"isConfirmed"] boolValue]  ;
    self.confirmBtn.enabled = !_myGame.isConfirmed;
    self.confirmBtn.backgroundColor = _myGame.isConfirmed ? [UIColor lightGrayColor] : [UIColor blueColor];
    
    
    //  获取self.oppUser的完整信息-（包含username等）
    [self.oppUser fetchInBackgroundWithKeys:@[@"username",@"nickname"] block:^(AVObject *object, NSError *error) {
    
        
        NSString *aScore = [game[@"aScore"] stringValue]  ? : kNullShortText;
        NSString *bScore = [game[@"bScore"] stringValue] ? : kNullShortText;
        
        _myGame.aScore = isAPlayerSelf ? aScore : bScore;
        _myGame.bScore = isAPlayerSelf ? bScore : aScore;
        
        block();
    }];
}

#pragma mark - IBAction
- (void)confirmAction:(id)sender
{
    //  1.如果比赛还未被加载！
    if (NO == _isGameLoaded || self.gameObject == nil) {
        return;
    }
    
    //  2.如果比赛已经被确认！
    BOOL isGameConfirmed = [self.gameObject[AVPropertyIsConfirmed] boolValue] ;
    if ( isGameConfirmed ) {
        [SVProgressHUD showInfoWithStatus:@"你已经确认比赛了"];
        return;
    }
    
    
    //  1.修改 Game的isConfirmed属性为YES
    [self.gameObject setObject:@YES forKey:AVPropertyIsConfirmed];
    [self.gameObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
       
        [SVProgressHUD showSuccessWithStatus:@"确认比赛成功"];
        self.myGame.isConfirmed = YES ;
        [self.tableView reloadData];
        
        [self debugMessage];
    }];
}


- (void)debugMessage
{
    float aBeforeScore = [[AVUser currentUser][@"score"] floatValue];
    float bBeforeScore = [self.oppUser[@"score"] floatValue];
    
    [[AVUser currentUser] fetchInBackgroundWithKeys:@[@"score"]  block:^(AVObject *object, NSError *error) {
       
        [self.oppUser fetchInBackgroundWithKeys:@[@"score"]  block:^(AVObject *object, NSError *error) {
            NSString *winner =  [self.myGame.aScore integerValue] >   [self.myGame.bScore integerValue] ? @"a" : @"b";
          
            NSLog(@"比赛后的分数：A=%f,  B=%f",[[AVUser currentUser][@"score"] floatValue],[self.oppUser[@"score"] floatValue]);
            
            NSString *title = [NSString stringWithFormat:@"赢者是%@",winner];
            NSString *beforeMessage = [NSString stringWithFormat:@"比赛前的分数：A=%f,  B=%f",aBeforeScore,bBeforeScore];
            NSString *connectString = @"\n";
            NSString *afterMessage = [NSString stringWithFormat:@"比赛后的分数：A=%f,  B=%f",[[AVUser currentUser][@"score"] floatValue],[self.oppUser[@"score"] floatValue]];
            NSString *message = [NSString stringWithFormat:@"%@ %@ %@",beforeMessage,connectString,afterMessage];
//            
//            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"比赛结果:" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alert show];
        }];
    }];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

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
    cell.aNameLabel.text = self.myGame.aPlayer.nickName;
    cell.bNameLabel.text = self.myGame.bPlayer.nickName;
    
    cell.aScoreLabel.text = self.myGame.aScore;
    cell.bScoreLabel.text = self.myGame.bScore;
    
    [cell.aAvatarImageView setImageWithURL:[NSURL URLWithString:self.myGame.aPlayer.avatarUrl] placeholder:kUserAvatarImage];
    [cell.bAvatarImageView setImageWithURL:[NSURL URLWithString:self.myGame.bPlayer.avatarUrl] placeholder:kUserAvatarImage];

    cell.confirmImageView.hidden = !self.myGame.isConfirmed;
    BOOL isAWinner =  [self.myGame.aScore integerValue] >     [self.myGame.bScore integerValue];
    cell.resultLabel.text = [NSString stringWithFormat:@"比赛结果: %@",isAWinner? @"胜利" : @"失败"];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 252;
}




@end
