//
//  DDCollectionViewController.h
//  UIViewControllerDetailTransition
//
//  Created by taitanxiami on 15/12/14.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCollectionViewController : UICollectionViewController

@property (nonatomic,assign)CGRect finalCellRect;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end
