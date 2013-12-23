//
//  ZAMainViewController.m
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-12-10.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import "ZAMainViewController.h"
#import "ZAHTTPManager.h"
#import <UIImageView+AFNetworking.h>

@interface ZAMainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelWashIndex;
@property (weak, nonatomic) IBOutlet UILabel *labelTodayTemp;
@property (weak, nonatomic) IBOutlet UILabel *labelTomorrowTemp;
@property (weak, nonatomic) IBOutlet UIImageView *today1ImgView;
@property (weak, nonatomic) IBOutlet UIImageView *today2ImgView;
@property (weak, nonatomic) IBOutlet UIImageView *tomorrow1ImgView;
@property (weak, nonatomic) IBOutlet UIImageView *tomorrow2ImgView;

@end

@implementation ZAMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[ZAHTTPManager sharedInstance] getWeatherInfoWithCompletion:^(int code, NSDictionary *weatherInfo) {
        if (code == 200) {
            NSString *temp1 = [weatherInfo objectForKey:@"temp1"];
            NSString *temp2 = [weatherInfo objectForKey:@"temp2"];
            NSString *washIndex = [weatherInfo objectForKey:@"index_xc"];
            NSString *img1 = [weatherInfo objectForKey:@"img1"];
            NSString *img2 = [weatherInfo objectForKey:@"img2"];
            NSString *img3 = [weatherInfo objectForKey:@"img3"];
            NSString *img4 = [weatherInfo objectForKey:@"img4"];
            NSString *img1Url = [NSString stringWithFormat:@"http://m.weather.com.cn/img/c%@.gif", img1];
            NSString *img2Url = [NSString stringWithFormat:@"http://m.weather.com.cn/img/c%@.gif", img2];
            NSString *img3Url = [NSString stringWithFormat:@"http://m.weather.com.cn/img/c%@.gif", img3];
            NSString *img4Url = [NSString stringWithFormat:@"http://m.weather.com.cn/img/c%@.gif", img4];
            [_labelWashIndex setText:washIndex];
            [_labelTodayTemp setText:temp1];
            [_labelTomorrowTemp setText:temp2];
            [_today1ImgView setImageWithURL:[NSURL URLWithString:img1Url]];
            [_today2ImgView setImageWithURL:[NSURL URLWithString:img2Url]];
            [_tomorrow1ImgView setImageWithURL:[NSURL URLWithString:img3Url]];
            [_tomorrow2ImgView setImageWithURL:[NSURL URLWithString:img4Url]];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
#pragma mark - Table view delegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        return 100;
//    }
//    return 70;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
