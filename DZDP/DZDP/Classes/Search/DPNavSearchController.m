//
//  test.m
//  DZDP
//
//  Created by nickchen on 15/10/10.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPNavSearchController.h"
#import "DPKeyWordController.h"
@interface DPNavSearchController ()<DPKeyWordControllerDelegate>

@end

@implementation DPNavSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DPKeyWordController *vc = (DPKeyWordController *)self.topViewController;
    vc.delegate = self;
}

+ (instancetype)sharedInstance{
    
    static DPNavSearchController * vc = nil;
    static dispatch_once_t predict;
    dispatch_once(&predict, ^{

        UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"DPNavSearchController" bundle:nil];
        vc = [stroryBoard instantiateInitialViewController];
        
    });
    return vc;
}

- (void)keyWordControllerCancleBtnClicked{
    
     [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)keyWordControllerSearchBtnClicked:(NSString *)keyWord{

    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    if ([self.proxy respondsToSelector:@selector(navSearchControllerGetkeyword:)]) {
        [self.proxy navSearchControllerGetkeyword:keyWord];
    }
  
}

- (void)setSearchBarText:(NSString *)text{
    
    DPKeyWordController *vc = (DPKeyWordController *)self.topViewController;
    vc.searchController.searchBar.text = text;

}

@end
