//
//  MGPinViewController.m
//
//  Created by Matt Glover on 17/04/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "MGPinViewController.h"
#import "PinViewTextField.h"
#import <QuartzCore/QuartzCore.h>

@interface MGPinViewController () <UITextFieldDelegate>

@property (nonatomic, copy) NSString *validPin;

@property (nonatomic, strong) PinViewTextField *pinOne;
@property (nonatomic, strong) PinViewTextField *pinTwo;
@property (nonatomic, strong) PinViewTextField *pinThree;
@property (nonatomic, strong) PinViewTextField *pinFour;

@end

@implementation MGPinViewController

- (id)init {
  return [self initWithValidPin:@"0000"];
}

- (id)initWithValidPin:(NSString *)validPin {
  self = [super init];
  if (self) {
    self.validPin = validPin;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Enter PIN";
  
  [self.view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1.0]];
  
  [self setupTextFields];
}


#pragma mark - Setup
- (void)setupTextFields {
  
  CGFloat frameY = [self isIPhone4Inch] ? 90 : 50;
  
  self.pinOne =   [self textFieldWithFrame:CGRectMake(10, frameY, 60, 60)  tag:1];
  [self.view addSubview:self.pinOne];
  
  self.pinTwo =   [self textFieldWithFrame:CGRectMake(90, frameY, 60, 60)  tag:2];
  [self.view addSubview:self.pinTwo];
  
  self.pinThree = [self textFieldWithFrame:CGRectMake(170, frameY, 60, 60) tag:3];
  [self.view addSubview:self.pinThree];
  
  self.pinFour =  [self textFieldWithFrame:CGRectMake(250, frameY, 60, 60) tag:4];
  [self.view addSubview:self.pinFour];
  
  [self.pinOne becomeFirstResponder];
}


#pragma mark - UITextFieldDelegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [textField setText:@""];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  
  [textField setText:string];
  [textField endEditing:YES];
  
  return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  
  NSInteger nextTag = textField.tag + 1;
  
  if (nextTag > 4) {
    [self validatePin];
  } else {
    UITextField *nextTextField = (UITextField *) [self.view viewWithTag:nextTag];
    [nextTextField becomeFirstResponder];
  }
}


#pragma mark - TextField Helper
- (PinViewTextField *)textFieldWithFrame:(CGRect)frame tag:(NSInteger)tag {
  
  PinViewTextField *textField = [[PinViewTextField alloc] initWithFrame:frame];
  [textField setTag:tag];
  
  [textField setBackgroundColor:[UIColor whiteColor]];
  [textField setFont:[UIFont boldSystemFontOfSize:46]];
  [textField setTextAlignment:UITextAlignmentCenter];
  [textField setSecureTextEntry:YES];
  [textField setKeyboardType:UIKeyboardTypeNumberPad];
  [textField setDelegate:self];
  
  [textField.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
  [textField.layer setBorderWidth:1.0f];
  
  return textField;
}


#pragma mark - Validate
- (void)validatePin {
  
  NSArray *strings = @[self.pinOne.text,
                       self.pinTwo.text,
                       self.pinThree.text,
                       self.pinFour.text];
  
  [self updateUIWithPinValid:[self validatePinWithStrings:strings]];
}

- (BOOL)validatePinWithStrings:(NSArray *)strings {
  
  NSMutableString *pin = [[NSMutableString alloc] init];
  for (NSString *string in strings) {
    [pin appendString:string];
  }
  
  return [self.validPin isEqualToString:pin];
}


#pragma mark - Update UI
- (void)updateUIWithPinValid:(BOOL)valid {
  
  if (valid) {
    NSLog(@"Success");
    [self dismissModalViewControllerAnimated:YES];
  } else {
    
    NSLog(@"Invalid Pin");
    
    self.pinOne.text    = @"";
    self.pinTwo.text    = @"";
    self.pinThree.text  = @"";
    self.pinFour.text   = @"";
    
    [self.pinOne becomeFirstResponder];
  }
}


#pragma mark - ScreenHeight Helper
- (BOOL)isIPhone4Inch {
  return (CGRectGetHeight([UIScreen mainScreen].bounds) == 568.0);
}

@end
