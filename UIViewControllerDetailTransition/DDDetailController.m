//
//  DDDetailController.m
//  UIViewControllerDetailTransition
//
//  Created by taitanxiami on 15/12/14.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "DDDetailController.h"
#import "DDCollectionViewController.h"
#import "DDDetailMissTransition.h"
@interface DDDetailController ()<UINavigationControllerDelegate>

@property (nonatomic,strong)UIPercentDrivenInteractiveTransition *percentDrivenTransiton;
@end
@implementation DDDetailController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
    
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
    
}

-(void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer{
    //计算手指滑的物理距离
    
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.percentDrivenTransiton = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.percentDrivenTransiton updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded ) {
        if (progress > 0.5) {
            
            [self.percentDrivenTransiton finishInteractiveTransition];
        }else {
            [self.percentDrivenTransiton cancelInteractiveTransition];
        }
        
        self.percentDrivenTransiton = nil;
    }
}

#pragma mark - UINavicationController delegate 
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[DDCollectionViewController class]]) {
        
        DDDetailMissTransition *transition = [[DDDetailMissTransition alloc]init];
        return transition;
    }else {
        return nil;
    }
}
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if([animationController isKindOfClass:[DDDetailMissTransition class]]){
        
        return self.percentDrivenTransiton;
    }else {
        return nil;
    }
}

@end
