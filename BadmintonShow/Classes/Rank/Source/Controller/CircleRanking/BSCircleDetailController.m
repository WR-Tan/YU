//
//  BSCircleDetailController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/27/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSCircleDetailController.h"
#import "BSCircleDetailHeader.h"
#import "BSCircleBusiness.h"


@interface BSCircleDetailController () <BSCircleDetailHeaderDelegate>
@property (nonatomic, strong) BSCircleDetailHeader *header;
@end

@implementation BSCircleDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructBaseView];
    [self updateCircle]; // to get creator
}

- (void)constructBaseView{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = self.circle.name;
        self.tableView.backgroundColor = [UIColor whiteColor];
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        
        CGFloat buttonHeight = 50;
        CGFloat buttonWidth = kScreenWidth - 30;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, self.view.height - buttonHeight, buttonWidth, 40 - 5);
        [button setBackgroundColor:[UIColor blueColor] ];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"加入圈子" forState:UIControlStateNormal];
        [button addTarget:self  action:@selector(queryIfJionedCricleCategory) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    });
}

- (void)updateCircle{
    //  获取Circle的User，和圈子的人数。
    [BSCircleBusiness fetchUserInBackgroundWithCircle:self.circle block:^(id object, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
            return ;
        }
        [self.tableView reloadData];
    }];
}


- (void)queryIfJionedCricleCategory {
    if ([self.circle.creator.objectId isEqualToString:AppContext.user.objectId]) {
        [SVProgressHUD showInfoWithStatus:@"你已经在圈内了"];
        return;
    }
    
    //  查询是否加入了某个分类圈:公司、学校、、、
    [BSCircleBusiness queryIfJionCategoryCircle:self.circle.category block:^(BOOL succeeded, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"请求数据失败.."];
            return;
        }
        
        if (!error && succeeded == NO) {
            NSString *message = [NSString stringWithFormat:@"你已经加入了%@分类圈，目前只支持加入一个分类圈(公开圈)中。如需加入当前圈子，请退出之前对应的分类圈",self.circle.category];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return ;
        }
        
        //  符合加入条件！
        [self queryIfJionInCircle];
    }];
    
}

- (void)queryIfJionInCircle{
    [BSCircleBusiness queryIfJionCertainCircle:self.circle block:^(BOOL succeeded, NSError *error) {
        if (!error && succeeded == NO) {
            [SVProgressHUD showErrorWithStatus:@"你已经在圈内了!"];
            return ;
        }
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"请求数据失败.."];
            return;
        }
        
        [self jionCircle];
    }];
}

- (void)jionCircle {
    
    [BSCircleBusiness jionCircel:self.circle object:^(BOOL succeeded, NSError *error) {
       
        if (error || !succeeded) {
            [SVProgressHUD showErrorWithStatus:@"加入失败"];
            return ;
        }
        
        [SVProgressHUD showSuccessWithStatus:@"加入成功"];
        NSInteger index=[[self.navigationController viewControllers]indexOfObject:self];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
    }];
    
    
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 500;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_header) {
        _header  = [BSCircleDetailHeader new];
        _header.delegate = self;
    }
    [_header setObject:self.circle];
    
    return _header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}


- (void)circleDetailHeader:(BSCircleDetailHeader *)header didClickCreator:(BSProfileUserModel *)creator{
    
}

- (void)didClickPeopleCountButton{
    
}





@end
