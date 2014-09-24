//
//  ReachMeDirectionsPageContentViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 23/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeDirectionsPageContentViewController.h"

@interface ReachMeDirectionsPageContentViewController ()

@end

@implementation ReachMeDirectionsPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.directionTitle.text = self.titleText;
    self.direction.text = self.directionText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
