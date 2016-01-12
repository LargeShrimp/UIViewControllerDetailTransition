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

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCell *shotCell = (DDCell *) cell;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)];
    
    scaleAnimation.toValue  = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [shotCell.layer addAnimation:scaleAnimation forKey:@"transform"];

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
