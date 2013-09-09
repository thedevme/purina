//
// Created by craigclayton on 12/30/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FindAContactCell_iPad.h"
#import "ContactData.h"


@implementation FindAContactCell_iPad

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