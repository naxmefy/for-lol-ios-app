//
//  FriendTableViewCell.m
//  For LoL
//
//  Created by Nax on 27.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "FriendTableViewCell.h"

@interface FriendTableViewCell()

@end

@implementation FriendTableViewCell

@synthesize textLabel, detailTextLabel, imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.imageView.image = [UIImage imageNamed:@"friend"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
