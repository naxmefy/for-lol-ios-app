//
//  FriendTableViewCell.h
//  For LoL
//
//  Created by Nax on 27.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailTextLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
