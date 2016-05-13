//
//  ViewController.m
//  dreamCatcher
//
//  Created by Pasha Bahadori on 5/11/16.
//  Copyright © 2016 Pelican Inc. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

// declaring UITableViewDataSource and ...Delegate gives us access to our tableView methods from the compiler
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *titles;
@property NSMutableArray *descriptionsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSMutableArray new];
    self.descriptionsArray = [[NSMutableArray alloc] init];
    // [new] and [alloc] init] do the same thing
   
    
    
    
    
}




// What to do when we want to present the prompt to the user so that they can add a dream
-(void)presentDreamEntry {
    // We call this method from our onAddButtonPressed method
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter New Dream" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Now we add a text field. The configuration handler is where we set any properties we want for the text field BEFORE they get added to the text fields
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Dream Title";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Dream Description";
    }];
    
    // This is the cancel UIAlert so the title is called "Cancel" and the style of the UIAlertAction is to cancel and the handler means what happens after you cancel and we set it to nil for nothing happens
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // This is where we handle if the user chooses to save
        // This will add the first text field to the array
        UITextField *textField1 = alertController.textFields.firstObject;
        [self.titles addObject:textField1.text];
        
        [self.descriptionsArray addObject:alertController.textFields.lastObject.text]; // Now we find a way to display this in our cell by changing the tableview cell CellID custom to "Subtitle" GO TO UITableViewCell to set that text
        
        // This reloads the data
        [self.tableView reloadData];
    }];
    // Now we need to add these actions to the alert controllers
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    // The completion executes any code that we'd want to happen after we present the view controller but we don't want anything to happen so we put nil
    [self presentViewController:alertController animated:true completion:nil];
}


// This decides what to display in the cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Now we've added the string to the array by saving a dream but we haven't modified our number of rows in section or selfrowindex path to actually change the text of the cell
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    //  indexPath.row gives us the corresponding row in our array that we're trying to display in our table view
    cell.textLabel.text = [self.titles objectAtIndex: indexPath.row];
    cell.detailTextLabel.text = [self.descriptionsArray objectAtIndex:indexPath.row];
    // Now we want to add the dream and dream description to a new page on our app
    return cell;
    
}

// These are the number of rows in each section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // Now that we have the array from UITableViewCell we can determine the number of rows in sections
    return self.titles.count;
}


- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    // We're going to change the order in which our dream entries appear
    if (self.editing == YES) {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;    // This gives the button a bold look so the user knows its finished
        sender.title = @"Done";
    }
}



// This lets us move and reorder the cells
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

// But if we move the order and we click on the description, the description hasn't been moved with the dream name, so we have to move the item in the array
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // The three code lines below move the title
    NSString *title = [self.titles objectAtIndex:sourceIndexPath.row];
    [self.titles removeObject:title];
    [self.titles insertObject:title atIndex:destinationIndexPath.row];
    
    NSString *description = [self.descriptionsArray objectAtIndex:sourceIndexPath.row];
    [self.descriptionsArray removeObject:description];
    [self.descriptionsArray insertObject:description atIndex:destinationIndexPath.row];
    
}


- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    [self presentDreamEntry];   // Now when we press the add button, presentDreamEntry method will be executed
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *dvc = segue.destinationViewController;
    dvc.titleString = [self.titles objectAtIndex:self.tableView.indexPathForSelectedRow.row];   //this will give us the index path of whatever row the user taps
    dvc.descriptionsString = [self.descriptionsArray objectAtIndex:self.tableView.indexPathForSelectedRow.row]; // Now we're setting the title string and the description string on our prepare for segue way but we DON'T do it in our DetailViewController.m file
}


// *DELETE METHOD* - This is where we can dictate what happens when we try to *DELETE* a row
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.titles removeObjectAtIndex:indexPath.row];
    [self.descriptionsArray removeObjectAtIndex:indexPath.row];
    
    // Then we need to reload the tableView's data so they can SEE that the dream listing is deleted
    [self.tableView reloadData];
    
}












@end
