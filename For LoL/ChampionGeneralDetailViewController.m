//
//  ChampionGeneralDetailViewController.m
//  For LoL
//
//  Created by Nax on 01.09.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "ChampionGeneralDetailViewController.h"

@interface ChampionGeneralDetailViewController ()

@end

@implementation ChampionGeneralDetailViewController
@synthesize champion;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.champion != nil) {
        self.tabBarController.title = [self.champion objectForKey:@"name"];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
