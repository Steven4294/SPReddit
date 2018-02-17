//
//  SPTableViewController.m
//  SPReddit
//
//  Created by Steven Petteruti on 2/15/18.
//  Copyright © 2018 Steven Petteruti. All rights reserved.
//

#import "SPTableViewController.h"
#import "SPTableViewCell.h"
#import "SPObjectManager.h"
#import "SPRedditPost.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
#import "IDMPhotoBrowser.h"

@interface SPTableViewController ()

@property NSMutableArray *redditPosts;
@property NSMutableArray *photos;


@end

@implementation SPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView layoutSubviews];
    self.redditPosts = [[NSMutableArray alloc] init];
    // fetch the data
    SPObjectManager *sharedManager = [SPObjectManager sharedManager];
    [sharedManager fetchDataWithCallback:^(NSArray *data, NSError *err) {
        if (err == nil) {
            self.redditPosts = [data mutableCopy];
            
            NSMutableArray *urls = [[NSMutableArray alloc] init];
            for (SPRedditPost *post in self.redditPosts) {
                NSString *suffix = [post.url substringFromIndex: [post.url length] - 3] ;
                
                if ([suffix isEqualToString:@"jpg"] || [suffix isEqualToString:@"png"]) {
                    [urls addObject:post.url];
                }else{
                    [urls addObject:post.thumbnailUrl];
                }
            }
            
            self.photos = [[IDMPhoto photosWithURLs:urls] mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else{
            NSLog(@"error fetching data: %@", err);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.redditPosts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"SPIdentifier";

    SPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[SPTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:MyIdentifier];
    }
    
    SPRedditPost *post = [self.redditPosts objectAtIndex:indexPath.row];
    cell.contentLabel.text = post.content;
    cell.commentsLabel.text = [NSString stringWithFormat:@"%d comments", post.comments];

    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
    formatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    formatter.maximumUnitCount = 1;

    NSString *elapsed = [formatter stringFromDate:[NSDate date] toDate:[NSDate dateWithTimeIntervalSinceNow:post.secondsAgo] ];

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"by %@ %@ ago", post.name, elapsed]];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:60.0/255.0f green:64/255.0f blue:198.0f/255.0f alpha:1.0f] range:NSMakeRange(3,post.name.length)];
    cell.secondaryLabel.attributedText = attrString;

    [cell.profileImageView sd_setShowActivityIndicatorView:YES];
    [cell.profileImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.profileImageView sd_setImageWithURL:[NSURL URLWithString:post.thumbnailUrl] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];

    [cell updateConstraintsIfNeeded];
    [cell layoutIfNeeded];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    IDMPhoto *photo = [self.photos objectAtIndex:indexPath.row];
    if (([photo.photoURL.absoluteString isEqualToString:@"default"] == false) && ([photo.photoURL.absoluteString isEqualToString:@"self"] == false)) {
        NSLog(@"photo url %@", photo.photoURL);
        IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:@[photo]];
        [self presentViewController:browser animated:YES completion:nil];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}


@end
