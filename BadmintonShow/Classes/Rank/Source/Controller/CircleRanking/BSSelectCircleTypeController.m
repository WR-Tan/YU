//
//  BSSelectCircleTypeController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/27/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSSelectCircleTypeController.h"
#import "BSCreateCircleTypeCell.h"

@interface BSSelectCircleTypeController ()

@end

static NSString *cellId = @"BSCreateCircleTypeCell";

@implementation BSSelectCircleTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择圈子类型";
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSCreateCircleTypeCell" bundle:nil] forCellReuseIdentifier:cellId];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSCreateCircleTypeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId ];
    
    //#warning 暂时只做公开的吧，私密的下个版本做。
    static NSString *openName = @"公开圈";
    static NSString *openMark = @"（创建一个公开的排名圈子）";
    static NSString *openDesc = @"        每个人都可以加入到你创建的公开圈子，前提是他/她的分类圈子(比如：公司)还没有加入其他公司的圈子。如果要加入另一个，必须退出之前对应分类圈子";
    
    static NSString *privateName = @"私密圈";
    static NSString *privateMark = @"（只有创建人能添加其他玩家）"; //，目前每个玩家只能创建1个
    static NSString *privateDesc = @"        私密圈是朋友间的分享、竞赛的小圈，需要创建人才能添加其他玩家到圈子中。在这里友谊第一，比赛第二。";
    
    cell.nameLabel.text = indexPath.row == 0 ? openName : privateName;
    cell.descLabel.text = indexPath.row == 0 ? openDesc : privateDesc;
    cell.markLable.text = indexPath.row == 0 ? openMark : privateMark;
    //    cell.nameLabel.text = openName;
    //    cell.descLabel.text = openMark;
    //    cell.markLable.text = openDesc;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BSCircleOpenType type = indexPath.row == 0 ? BSCircleOpenTypeOpen : BSCircleOpenTypePrivate;
    if ([self.delegate respondsToSelector:@selector(didSelectOpenType:)]) {
        [self.delegate didSelectOpenType:type];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
