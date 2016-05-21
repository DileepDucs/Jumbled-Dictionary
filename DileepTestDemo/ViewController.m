//
//  ViewController.m
//  DileepTestDemo
//
//  Created by cdp on 27/05/15.
//  Copyright (c) 2015 dileep. All rights reserved.
//

#import "ViewController.h"
#import "SearchResultTableViewController.h"

@interface ViewController ()

@end


static NSMutableSet *results;
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.inputTextField.delegate = self;
}

- (NSArray *)searchString:(NSMutableSet *)permuteSet{
    // Get the Path for the dictionary.txt file.
    NSString* path = [[NSBundle mainBundle] pathForResource:@"dictionary"
                                                     ofType:@"txt"];
    NSError *error = nil;
    // Read the contents of the file into a string.
    NSString *fileContentsString = [NSString stringWithContentsOfFile:path
                                                             encoding:NSUTF8StringEncoding
                                                                error:&error];
    // Make sure that the file has been read, log an error if it hasn't.
    if (!fileContentsString) {
        NSLog(@"Error reading file");
        return nil;
    }
    //read all the words from a large string having newline, whiteSpace and store in to array.
    NSArray* words = [fileContentsString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSMutableSet* fileSet = [NSMutableSet setWithArray:words];
    [permuteSet intersectSet:fileSet];
    
    //this will give you only the obejcts that are in both sets.
    NSArray* result = [permuteSet allObjects];
    return result;
}

void permute(NSMutableArray *input, NSMutableArray *output, NSMutableArray *used, int size, int level) {
    if (size == level) {
        NSString *word = [output componentsJoinedByString:@""];
        [results addObject:word];
        return;
    }
    level++;
    for (int i = 0; i < input.count; i++) {
        if ([used[i] boolValue]) {
            continue;
        }
        used[i] = [NSNumber numberWithBool:YES];
        [output addObject:input[i]];
        permute(input, output, used, size, level);
        used[i] = [NSNumber numberWithBool:NO];
        [output removeLastObject];
    }
}

NSMutableSet *getPermutations(NSString *input, int size) {
    results = [[NSMutableSet alloc] init];
    NSMutableArray *chars = [[NSMutableArray alloc] init];
    for (int i = 0; i < [input length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [input characterAtIndex:i]];
        [chars addObject:ichar];
    }
    NSMutableArray *output = [[NSMutableArray alloc] init];
    NSMutableArray *used = [[NSMutableArray alloc] init];
    for (int i = 0; i < chars.count; i++) {
        [used addObject:[NSNumber numberWithBool:NO]];
    }
    permute(chars, output, used, size, 0);
    return results;
}

- (IBAction)searchButtonPress:(UIButton *)sender {
    NSString *inputString = self.inputTextField.text;
    NSUInteger size = [inputString length];
    if(size < 10) {
        NSArray *array = [[NSMutableArray alloc] init];
        self.inputTextField.text = nil;
        //array containg comman strings.
        array = [self searchString:getPermutations(inputString, (int)size)];
        if([array count] > 0) {
            SearchResultTableViewController *viewController = [[SearchResultTableViewController alloc] init];
            viewController.searchResult = [NSArray arrayWithArray:array];
            [self.navigationController pushViewController:viewController animated:YES];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message!" message:@"String not found." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }else {
        //show alert if string length should not greater then 10.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message!" message:@"String size not greaater then 10" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];

    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
