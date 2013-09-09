//
//  FindAContactCell.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/25/12.
//
//

#import "FindAContactCell.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"


@implementation FindAContactCell



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
