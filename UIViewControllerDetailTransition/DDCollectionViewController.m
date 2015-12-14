//
//  DDCollectionViewController.m
//  UIViewControllerDetailTransition
//
//  Created by taitanxiami on 15/12/14.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "DDCollectionViewController.h"
#import "DDCell.h"
#import "DDDetailController.h"
#import "DDDetailTransiton.h"
static NSString *const CellIdentify = @"CellIDentify";
@interface DDCollectionViewController ()<UINavigationControllerDelegate>

@end
@implementation DDCollectionViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentify forIndexPath:indexPath];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    DDDetailController *detailVC = segue.destinationViewController;
    
}
#pragma mark - UINavicationController delegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[DDDetailController class]]) {
        
        DDDetailTransiton *transition = [[DDDetailTransiton alloc]init];
        return transition;
    }else {
        return nil;
    }
    
}

@end
