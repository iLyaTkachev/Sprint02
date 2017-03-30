//
//  ViewController.m
//  Sprint01ARC
//
//  Created by iLya Tkachev on 3/24/17.
//  Copyright © 2017 iLya Tkachev. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

NSArray *dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    dataArray = [[NSArray alloc] initWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = (MyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.myTitleLabel.text=[[dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.mySubtitleLabel.text=[[dataArray objectAtIndex:indexPath.row] objectForKey:@"subtitle"];
    cell.myImageView.image = [UIImage imageNamed:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"image_name"]];

    return cell;
}
@end
