//
//  DPSearchWordController.m
//  DZDP
//
//  Created by nickchen on 15/10/9.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPKeyWordSearchResultController.h"

@interface DPKeyWordSearchResultController ()

@end

@implementation DPKeyWordSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"word"];
   
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.filteredWords.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"word" forIndexPath:indexPath];
    
    cell.textLabel.text = _filteredWords[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *word =  _filteredWords[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(KeyWordSearchResultControllerGetWord:)]) {
        [self.delegate KeyWordSearchResultControllerGetWord:word];
    }

}

@end
