//
//  TableViewController.m
//  ZCJTableViewCellDemo
//
//  Created by zhangchaojie on 16/8/23.
//  Copyright © 2016年 zhangchaojie. All rights reserved.
//

#import "TableViewController.h"
#import "ZCJTableViewCell.h"
#import "NSMutableArray+ZCJButton.h"

@interface TableViewController ()<ZCJTableViewCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;
    self.tableView.allowsSelection = NO; // We essentially implement our own selection
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.tableView registerClass:[ZCJTableViewCell class] forCellReuseIdentifier:@"MyCell"];
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
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    ZCJTableViewCell *cell = (ZCJTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    //    if (cell == nil) {
    NSMutableArray *btns = [[NSMutableArray alloc] initWithCapacity:5];
    [btns addButtonWithBackgroundColor:[UIColor grayColor] withTitle:@"More"];
    [btns addButtonWithBackgroundColor:[UIColor redColor] withTitle:@"Delete"];
    
    ZCJTableViewCell *cell = [[ZCJTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell" parentTableView:self.tableView rightButtons:btns];
    //    }
    cell.delegate = self;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
    
    return cell;
}


- (void)swippableTableViewCell:(ZCJTableViewCell *)cell didTriggerRightButtonViewWithIndex:(NSInteger)index{
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    switch (index) {
        case 0:
        {
            NSLog(@"More button was pressed, indexPath:%ld", (long)cellIndexPath.row);
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"More more more" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            
            //            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            NSLog(@"Delete button was pressed, indexPath:%ld", (long)cellIndexPath.row);
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"Delete button was pressed" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            break;
        }
        default:
            break;
    }
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
