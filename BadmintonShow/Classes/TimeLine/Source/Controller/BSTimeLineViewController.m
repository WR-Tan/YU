//
//  BSTimeLineViewController.m
//  BadmintonShow
//
//  Created by LZH on 15/12/11.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "BSTimeLineViewController.h"
#import "YYTableView.h"
#import "YYKit.h"
#import "AVQuery.h"
#import "BSTLModel.h"

@interface BSTimeLineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *layouts;
@end

@implementation BSTimeLineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
    
    AVQuery *quer = [AVQuery queryWithClassName:@"Status"];
    [quer includeKey:@"pics"];
    [quer includeKey:@"user"];
    [quer findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        AVObject *status = objects[0];
        
        BSTLModel *tlModel = [BSTLModel modelWithAVObject:status];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
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
