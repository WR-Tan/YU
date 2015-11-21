//
//  BSConfirmGameTableViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/11/20.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSConfirmGameTableViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface BSConfirmGameTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView ;
@property (nonatomic, strong) AVObject *gameObject;
@end

@implementation BSConfirmGameTableViewController

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
    
    [self.view addSubview:self.tableView];
    
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(0, kScreenHeigth - 44 , kScreenWidth, 44);
    [confirmBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor blueColor];
    [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

- (void)initData
{

    AVQuery *query = [AVQuery queryWithClassName:@"TempGame"];
    [query whereKey:@"objectId" equalTo:self.tempGameObjectId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //  1.取出数组
            self.gameObject = [objects firstObject];
            //  2.取出临时比分模型
            [self valiateIsFirstOfPlayerInfo:^(bool isFirst) {
                //   如果比赛唯一&&正确，那么将这个比赛数据插入到
                //   B的PlayerInfo类的tempGames数组中
                if (isFirst) {
                    [self uploadGameObject:self.gameObject];
                }
                
            }];
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}



//  检验收到的比赛是不是比赛栈的最底部。
- (void)valiateIsFirstOfPlayerInfo:(void (^)(bool isFirst))blocks
{
    //  1.通过查询获取playerInfo对象
    AVQuery *query = [AVQuery queryWithClassName:@"PlayerInfo"];
    [query whereKey:@"userObjectId" equalTo:self.gameObject[@"playerA_objectId"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        //  如果比赛是同一个：id一样， 另外还要对比分
        AVObject *tempGame = [objects firstObject];
        if ([tempGame.objectId isEqualToString: self.gameObject.objectId]) {
            
            // 这里还要加排名分数的比较的  rankScore
            
            
            blocks(YES);
        }else{
            blocks(NO);
        }
    }];
}


- (void)uploadGameObject:(AVObject *)gameObject
{
     ;
}


#pragma mark - Private Method
- (void)confirmAction:(UIButton *)sender
{
     ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ConfirmGameCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
