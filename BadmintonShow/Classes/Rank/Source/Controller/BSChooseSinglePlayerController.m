//
//  BSChooseSinglePlayerController.m
//  BadmintonShow
//
//  Created by lizhihua on 12/20/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSChooseSinglePlayerController.h"

@interface BSChooseSinglePlayerController ()

@end

@implementation BSChooseSinglePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"选择男单/女单的对手";
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
