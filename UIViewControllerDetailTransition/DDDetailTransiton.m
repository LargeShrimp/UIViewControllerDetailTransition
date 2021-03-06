//
//  DDDetailTransiton.m
//  UIViewControllerDetailTransition
//
//  Created by taitanxiami on 15/12/14.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "DDDetailTransiton.h"
#import "DDCell.h"
#import "DDCollectionViewController.h"
#import "DDDetailController.h"
@implementation DDDetailTransiton

/**
 *  动画时间
 *
 *  @param transitionContext <#transitionContext description#>
 *
 *  @return <#return value description#>
 */
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.6f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
//  拿到两个视图控制器和视图容器
    UIView *containtVIew  = [transitionContext containerView];
    DDCollectionViewController *fromVC = (DDCollectionViewController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DDDetailController *toVC = (DDDetailController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
//  获取选中cell
    NSIndexPath *selectIdx = [[fromVC.collectionView indexPathsForSelectedItems] firstObject];
    DDCell *cell = (DDCell*) [fromVC.collectionView cellForItemAtIndexPath:selectIdx];
    fromVC.indexPath = selectIdx;

//  生成截图,并设置截图的frame
    UIView *snapimageView = [cell.cellImageView snapshotViewAfterScreenUpdates:NO];
    snapimageView.frame = fromVC.finalCellRect = [containtVIew convertRect:cell.cellImageView.frame fromView:cell.cellImageView.superview];
    cell.cellImageView.hidden = YES;

//  设置将要现实的view 属性
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0.0f;
    toVC.detailImageView.hidden = YES;
    
    [containtVIew addSubview:toVC.view];
    [containtVIew addSubview:snapimageView];

    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        // 动画
        [containtVIew layoutIfNeeded];

        toVC.view.alpha = 1.0f;
        //toVC.detailImageView 的frame 在父视图view中的位置
        snapimageView.frame  =[ containtVIew convertRect:toVC.detailImageView.frame toView:toVC.view];



    } completion:^(BOOL finished) {
        
        toVC.detailImageView.hidden = NO;
        cell.cellImageView.hidden = NO;
        [snapimageView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//       
//        toVC.view.alpha = 1.0f;
//        imageView.frame = [containtVIew convertRect:toVC.detailImageView.frame fromView:toVC.view];
//        
//    } completion:^(BOOL finished) {
//
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//    }];
    
    
}

@end
