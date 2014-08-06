//
//  DefaultNavigationViewController.m
//  For LoL
//
//  Created by Nax on 30.07.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "DefaultNavigationViewController.h"

@interface DefaultNavigationViewController ()

@end

@implementation DefaultNavigationViewController

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
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    //[anotherButton setImage:[UIImage imageNamed:@"Menu"]];
    self.navigationItem.leftBarButtonItem = anotherButton;
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

- (void)showMenu {
    NSLog(@"LOL");
}

@end
