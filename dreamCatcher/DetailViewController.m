//
//  DetailViewController.m
//  dreamCatcher
//
//  Created by Pasha Bahadori on 5/12/16.
//  Copyright © 2016 Pelican Inc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;




@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.descriptionsString;
    self.title = self.titleString;
    
    // In our viewDidLoad we will use the textView IBOutlet to set the text to the text field

    
}

/*
 #Pragma Mark - Navigation
 
 In a storyboard-based application, you will often want to do a little preparation before navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController]
 // Pass the selected object to the new view controller
 
 */

@end
