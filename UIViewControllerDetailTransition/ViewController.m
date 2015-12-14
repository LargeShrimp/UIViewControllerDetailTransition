//
//  ViewController.m
//  UIViewControllerDetailTransition
//
//  Created by taitanxiami on 15/12/14.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "ViewController.h"
#import "DDCell.h"
static NSString *const CellIDentify = @"CellIDentify";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIDentify forIndexPath:indexPath];
    
    return cell;
    
    
}


@end
