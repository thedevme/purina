//
// Created by craigclayton on 11/30/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "ContactData.h"

@interface PetContactView : UIView {
    UIImageView *_imgSeeAll;
}

@property(nonatomic, strong) UILabel *lblType;
@property(nonatomic, strong) UILabel *lblName;
@property(nonatomic, strong) UILabel *lblAddress;
@property(nonatomic, strong) UILabel *lblCity;
@property(nonatomic, strong) UILabel *lblPhone;
@property(nonatomic, strong) UILabel *lblSeeAll;
@property(nonatomic, strong) UIButton *iconEmail;



@property(nonatomic, strong) UIButton *iconMap;

@property(nonatomic, strong) UIImageView *imgSeeAll;

@property(nonatomic, strong) UIImageView *imgLine;

@property(nonatomic, copy) NSString *petType;

@property(nonatomic, strong) NSArray *arrContacts;

@property(nonatomic, retain) ContactData* objPrimaryContact;

@property(nonatomic, strong) id clController;

- (id)initWithContactData:(ContactData *)data withType:(NSString *)type;
- (void) updateCard:(ContactData *)data;

@end