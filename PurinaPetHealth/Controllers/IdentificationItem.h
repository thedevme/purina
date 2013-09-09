//
//  IdentificationItem.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/20/12.
//
//

#import <UIKit/UIKit.h>

@class PetItem;

@interface IdentificationItem : UIView

@property(nonatomic, strong) UILabel *lblName;

@property(nonatomic, copy) NSString *label;

@property(nonatomic, copy) NSString *value;

@property(nonatomic, strong) UILabel *lblValue;

- (id)initWithLabel:(NSString *)label andData:(NSString *)data;

@end
