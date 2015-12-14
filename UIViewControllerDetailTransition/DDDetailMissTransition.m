//
//  DDDetailMissTransition.m
//  UIViewControllerDetailTransition
//
//  Created by taitanxiami on 15/12/14.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "DDDetailMissTransition.h"
#import "DDDetailController.h"
#import "DDCollectionViewController.h"
#import "DDCell.h"
@implementation DDDetailMissTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.6f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //获取对应的controller and containtView
    DDCollectionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    DDDetailController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *contraintView = [transitionContext containerView];
    
    UIView *snapView = [fromVC.detailImageView snapshotViewAfterScreenUpdates:NO];
    snapView.backgroundColor = [UIColor clearColor];
    snapView.frame = [contraintView convertRect:fromVC.detailImageView.frame fromView:fromVC.view];
    fromVC.detailImageView.hidden = YES;
    
    
    DDCell * cell = (DDCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.indexPath];
    cell.cellImageView.hidden = YES;
    
    [contraintView insertSubview:toVC.view belowSubview:fromVC.view];
    [contraintView addSubview:snapView];
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        fromVC.view.alpha = 0.0f;
        snapView.frame = toVC.finalCellRect;
        
    } completion:^(BOOL finished) {
        [snapView removeFromSuperview];
        fromVC.detailImageView.hidden = NO;
        cell.cellImageView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }];
}
@end
