//
//  ViewController.m
//  Tipster
//
//  Created by Connor Clancy on 6/26/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billField;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

@property (weak, nonatomic) IBOutlet UIView *background;

@property (weak, nonatomic) IBOutlet UILabel *billSplit;

@property (weak, nonatomic) IBOutlet UISegmentedControl *numberOfPeople;

@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation ViewController

bool start = true;



- (void)viewDidLoad {
    [super viewDidLoad];
    // initial screen only has bill input field
    self.tipLabel.alpha = 0;
    self.totalLabel.alpha = 0;
    self.tipControl.alpha = 0;
    self.background.alpha = 0;
    self.clearButton.alpha = 0;
    // place bill input field toward middle
    CGRect newFrame = self.billField.frame;
    newFrame.origin.y = self.view.center.y- 75;
    self.billField.frame = newFrame;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    
    [self.view endEditing:YES];
    double bill = [self.billField.text doubleValue];
    NSArray *percentages = @[@(0.15), @(0.20), @(0.22)];
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    double tip = tipPercentage * bill;
    double total = bill + tip;
    double splitTotal = total  / [@[@(1), @(2), @(3), @(4), @(5)][self.numberOfPeople.selectedSegmentIndex] doubleValue];
    self.billSplit.text = [NSString stringWithFormat:@"%.2f", splitTotal];
}


- (IBAction)onEdit:(id)sender {
    
    double bill = [self.billField.text doubleValue];
    NSArray *percentages = @[@(0.15), @(0.20), @(0.22)];
    
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = tipPercentage * bill;
    double total = bill + tip;
    bill = total;
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];

}

- (IBAction)initialTap:(id)sender {
    // only on initial tap set up functional screen
    if (start) {
        CGRect newFrame = self.billField.frame;
        newFrame.origin.y -= 165;
        [UIView animateWithDuration:1 animations:^{
            self.billField.frame = newFrame;
            self.tipLabel.alpha = 1;
            self.totalLabel.alpha = 1;
            self.tipControl.alpha = 1;
            self.background.alpha = 1;
            self.clearButton.alpha = 1;
        }];
        
    }
    start = false;
}

- (IBAction)updateSplit:(id)sender {
    double bill = [self.billField.text doubleValue];
    NSArray *percentages = @[@(0.15), @(0.20), @(0.22)];
    
    // recalculate bill
    // TODO if have time add a global that stores the bill
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    double tip = tipPercentage * bill;
    double total = bill + tip;
    double splitTotal = total  / [@[@(1), @(2), @(3), @(4), @(5)][self.numberOfPeople.selectedSegmentIndex] doubleValue];
    self.billSplit.text = [NSString stringWithFormat:@"%.2f", splitTotal];
}

- (IBAction)buttonClear:(id)sender {
    self.billField.text = @"";
    self.totalLabel.text = @"$0.00";
    self.tipLabel.text = @"$0.00";
    self.billSplit.text = @"$0.00";
}

@end
