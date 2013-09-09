//
//  FindAContactCell_iPhone.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/27/12.
//
//
#import "FindAContactCell_iPhone.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"


@implementation FindAContactCell_iPhone

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)onAddTapped:(id)sender
{
    NSLog(@"add tapped");
    [self.delegate addContact:self.objContactData];
    //[[NSNotificationCenter defaultCenter] postNotificationName:kAddNewContact object:_objContactData];
}

@end
