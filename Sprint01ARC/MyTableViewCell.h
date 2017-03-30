//
//  MyTableViewCell.h
//  Sprint01ARC
//
//  Created by iLya Tkachev on 3/24/17.
//  Copyright © 2017 iLya Tkachev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *myTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *mySubtitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@end
