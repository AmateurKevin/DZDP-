//
//  DPDropdownMenu.m
//  DZDP
//
//  Created by nickchen on 15/7/6.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPDropdownMenu.h"

@interface DPDropdownMenu ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet UITableView *subTable;

@end


@implementation DPDropdownMenu

+ (instancetype)dropdownMenu
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPDropdownMenu" owner:nil options: nil] lastObject];
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self.mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:mainID];
    [self.subTable registerClass:[UITableViewCell class] forCellReuseIdentifier:subID];

    [self.mainTable reloadData];
    [self.subTable reloadData];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTable) {
        return self.items.count;
    }else{
        id<DPDropdownMenuItemDelegate> item = self.items[self.mainTable.indexPathForSelectedRow.row];
        return [item subTitles].count;
    }
}

static NSString *mainID = @"main";
static NSString *subID = @"sub";

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (tableView == self.mainTable) {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
       
        cell.textLabel.text = [self.items[indexPath.row] title];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        return cell;
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:subID];
      
        id<DPDropdownMenuItemDelegate> item = self.items[self.mainTable.indexPathForSelectedRow.row];
        cell.textLabel.text = [item subTitles][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTable) {
        [self.subTable reloadData];
        if ([self.delegate respondsToSelector:@selector(dropdownMenu:didSelectMain:)]) {
            [self.delegate dropdownMenu:self didSelectMain:indexPath.row];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(dropdownMenu:didSelectSub:ofMainRow:)]) {
            NSInteger mainRow = self.mainTable.indexPathForSelectedRow.row;
            [self.delegate dropdownMenu:self didSelectSub:indexPath.row ofMainRow:mainRow];
        }
    }
}


@end
