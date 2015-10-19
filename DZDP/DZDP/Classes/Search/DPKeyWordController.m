//
//  testTable.m
//  DZDP
//
//  Created by nickchen on 15/10/10.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPKeyWordController.h"
#import "DPKeyWordSearchResultController.h"

@interface DPKeyWordController ()<UISearchControllerDelegate,UISearchBarDelegate,UISearchResultsUpdating>


// 搜索结果控制器(搜索关键词选择的界面)
@property (nonatomic, strong) DPKeyWordSearchResultController *keyWordSearchResultController;

@property(nonatomic,strong) NSArray *tipWords;

@end

@implementation DPKeyWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initAttributes];
    
    [self configureSearchController];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"word"];
   
}

- (void)initAttributes{
    
    _tipWords = @[@"酒店",@"电影",@"足疗",@"KTV",@"火锅",@"粤菜",@"川菜",@"湘菜"];
}

- (void)configureSearchController{
    
    _keyWordSearchResultController = [[DPKeyWordSearchResultController alloc] init];
    
    // Init UISearchController with the search results controller
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_keyWordSearchResultController];
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.searchController.searchBar.placeholder = @"请输入商家或地点";
    
    [self.searchController.searchBar becomeFirstResponder];
    self.navigationItem.titleView = self.searchController.searchBar;
    [self.searchController.searchBar sizeToFit];
    
    self.definesPresentationContext = YES;
    
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _tipWords.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"word" forIndexPath:indexPath];
    
    cell.textLabel.text = _tipWords[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *word =  _tipWords[indexPath.row];
    
    [self getkeyword:word];
    
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [self.tipWords mutableCopy];
    
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[cd] %@ OR SELF contains[cd] %@",searchText,searchText];
    
    searchResults = [[searchResults filteredArrayUsingPredicate:titlePredicate] mutableCopy];
    
    // hand over the filtered results to our search results table
    DPKeyWordSearchResultController *wordController = (DPKeyWordSearchResultController *)self.searchController.searchResultsController;
    wordController.filteredWords = searchResults;
    [wordController.tableView reloadData];
}

#pragma mark -- UISearchBarDelegate

/**
 *  点击键盘的搜索按钮跳转
 *
 *  @param searchBar 搜索栏
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self getkeyword:searchBar.text];
    
    searchBar.text = nil;
}

- (void)getkeyword:(NSString *)keyword{
    
    if ([self.delegate respondsToSelector:@selector(keyWordControllerSearchBtnClicked:)]) {
        
        [self.delegate keyWordControllerSearchBtnClicked:keyword];
        
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    if ([self.delegate respondsToSelector:@selector(keyWordControllerCancleBtnClicked)]) {
        
        [self.delegate keyWordControllerCancleBtnClicked];
        
    }
    
    
}

//- (void)viewWillAppear:(BOOL)animated{}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _searchController.active = YES;
    [_searchController.searchBar becomeFirstResponder ];
}

@end
