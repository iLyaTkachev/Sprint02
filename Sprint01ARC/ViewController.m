//
//  ViewController.m
//  Sprint01ARC
//
//  Created by iLya Tkachev on 3/24/17.
//  Copyright © 2017 iLya Tkachev. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "HTTPCommunication.h"
#import "CustomViewController.h"
#import "CarMO.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize fetchedResultsController = _fetchedResultsController;
NSArray *dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    //dataArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    //dataArray = [[NSArray alloc]init];
    //[self retrieveInfo];
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
}
- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"CarMO" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"Car.mark" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:_managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate=self;
    
    return _fetchedResultsController;
    
}
- (IBAction)updateClick:(id)sender {
    //[self retrieveInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(MyTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CarMO *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.myTitleLabel.text = info.mark;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = (MyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
[self configureCell:cell atIndexPath:indexPath];
    //cell.myTitleLabel.text=[[dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    //cell.mySubtitleLabel.text=[[dataArray objectAtIndex:indexPath.row] objectForKey:@"subtitle"];
    
        return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showAutoDetail"]) {
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        CustomViewController *detailViewController = segue.destinationViewController;
        detailViewController.titleText = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    }
}

- (void)retrieveInfo
{
    HTTPCommunication *http = [[HTTPCommunication alloc] init];
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/iLyaTkachev/Sprint02/master/Sprint01ARC/File.json"];
    // получаем info
    [http retrieveURL:url myBlock:^(NSArray *array)
     {
         dataArray=array;
         [self.myTableView reloadData];
     }];
    
}

- (void)downloadImage :(UIImage*)cellImage URL:(NSString *)url
{
    //cellImage = nil;
    __block UIImage *myImage=cellImage;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                myImage=image;
                });
            }
        });
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.myTableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.myTableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.myTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.myTableView endUpdates];
}

@end
