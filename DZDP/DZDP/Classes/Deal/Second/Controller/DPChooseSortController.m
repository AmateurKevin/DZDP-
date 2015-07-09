//
//  DPChooseSortController.m
//  DZDP
//
//  Created by nickchen on 15/7/6.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPChooseSortController.h"
#import "DPMetaDataTool.h"
#import "DPSort.h"
@interface DPChooseSortController ()
@property(nonatomic,strong) NSArray *sorts;
@end


static NSString *ID = @"sort";
@implementation DPChooseSortController

- (NSArray *)sorts
{
    if (_sorts == nil) {
        _sorts = [DPMetaDataTool sorts];
    }
    return _sorts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sorts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [self.sorts[indexPath.row] label];
    
    return cell;
}

@end