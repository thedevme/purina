//
//  PetPickerViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/25/12.
//
//

#import <UIKit/UIKit.h>
#import "TDSemiModalViewController.h"
#import "ALPickerView.h"

@class PetModel;

@protocol PetPickerDelegate <NSObject>

- (void)doneWithPets:(NSArray *)pets;
- (void)dismiss;

@end

@interface PetPickerViewController : UIViewController  <ALPickerViewDelegate> {




}

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, weak) id <PetPickerDelegate> delegate;
@property(nonatomic, strong) PetModel *petModel;

@property (nonatomic, strong) NSMutableArray *petNames;
@property (nonatomic, strong) NSMutableArray *petData;
@property (nonatomic, strong) NSMutableArray *petIds;
@property (nonatomic, strong) NSMutableArray *selectedPets;
@property (nonatomic, strong) NSMutableArray *selectedPetsData;
@property (nonatomic, strong) NSMutableDictionary *selectionStates;

@property (nonatomic, strong) ALPickerView *pickerView;

@end
