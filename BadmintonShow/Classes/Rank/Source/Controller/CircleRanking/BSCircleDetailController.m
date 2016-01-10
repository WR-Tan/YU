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
#import "BSPhotoPicker.h"
#import "BSCircleMemberController.h"


@interface BSCircleDetailController () <BSCircleDetailHeaderDelegate>
@property (nonatomic, strong) BSCircleDetailHeader *header;
@property (nonatomic, strong) UIButton *jionButton;
@end

@implementation BSCircleDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructBaseView];
    [self updateCircle]; // to get creator
}

- (void)constructBaseView{
    
    self.title = self.circle.name;
    self.tableView.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    CGFloat buttonHeight = 50;
    CGFloat buttonWidth = kScreenWidth - 30;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, self.view.height - buttonHeight - 64, buttonWidth, 40 - 5);
    //        [button setBackgroundColor:[UIColor blueColor] ];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"加入圈子" forState:UIControlStateNormal];
    [button addTarget:self  action:@selector(queryIfJionedCricleCategory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.jionButton = button;
}

- (void)updateCircle{
    BOOL isCreatorSelf = [self.circle.creator.objectId isEqualToString:AppContext.user.objectId];
    self.jionButton.enabled = !isCreatorSelf  ;
    UIImage *buttonImage = isCreatorSelf ? [UIImage imageWithColor:[UIColor lightGrayColor]] :[UIImage imageWithColor:[UIColor blueColor]];
    [self.jionButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.tableView reloadData];
    
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
        self.jionButton.enabled = NO;
        [SVProgressHUD showInfoWithStatus:@"你已经在圈内了"];
        return;
    }
    
    self.jionButton.enabled = NO;
    //  查询是否加入了某个分类圈:公司、学校、、、
    [BSCircleBusiness queryIfJionCategoryCircle:self.circle.type block:^(BOOL succeeded, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"请求数据失败.."];
            return;
        }
        
        
        /// 暂时可以加入对应的其他公司/学校/公开圈吧。别太复杂
#if 0
        if (!error && succeeded == NO) {
            NSString *circleType = [[self typeDict] objectForKey:self.circle.type] ? : @"";
            NSString *title = [NSString stringWithFormat:@"你已经加入了%@分类圈，目前只支持加入一个分类圈(公开圈)中。如需加入当前圈子，请退出之前对应的分类圈",circleType];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil  delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return ;
        }
#endif
        
        //  符合加入条件！
        [self queryIfJionInCircle];
    }];
}

- (NSDictionary *)typeDict{
    return  @{@"company" : @"公司",
              @"school"  : @"学校",
              @"city"    : @"城市",
              @"district": @"区域",
              @"court"   : @"小区",
              @"club"    : @"球会",
              @"other"   : @"其他"};
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
        if (self.block) {
            self.block();
        }
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

- (void)circleDetailHeader:(BSCircleDetailHeader *)header didClickCircleAvatar:(UIImageView *)avatarView {
    
    //  不能编辑头像
    if (![self.circle.creator.objectId isEqualToString:AppContext.user.objectId]) return;
    
    //  可以编辑头像
    [BSPhotoPicker viewController:self pickImageWithBlock:^(id object, NSError *error) {
        if ([object isKindOfClass:[UIImage class]]) {  // 上传图片
            [BSCircleBusiness saveCircleAvatarWithId:self.circle.objectId image:object
                                               block:^(id object, NSError *error) {
                                                   if (error) {
                                                       [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
                                                       return ;
                                                   }
                                                   self.circle.avatarUrl = (NSURL *)object;
                                                   [self.tableView reloadData];
                                               }];
        } else {
            [SVProgressHUD showErrorWithStatus:@"获取图片失败"];
        }
    }];
    
}

- (void)circleDetailHeader:(BSCircleDetailHeader *)header didClickCreator:(BSProfileUserModel *)creator{
    
}

- (void)didClickPeopleCountButton{
    BSCircleMemberController *memberVC = [[BSCircleMemberController alloc] init];
    memberVC.circle  = self.circle;
    [self.navigationController pushViewController:memberVC animated:YES];
}





@end
