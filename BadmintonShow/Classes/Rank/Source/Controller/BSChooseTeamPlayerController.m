//
//  BSChooseTeamPlayerController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSChooseTeamPlayerController.h"

@interface BSChooseTeamPlayerController ()

@end

@implementation BSChooseTeamPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"选择男双/女双/混双的对手";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Id = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Id];
    }
    return cell;
}

@end
