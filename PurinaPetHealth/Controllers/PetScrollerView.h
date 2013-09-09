//
//  PetScrollerView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/29/12.
//
//

#import <UIKit/UIKit.h>
#import "PetCardView.h"
#import "PetModel.h"
#import "AddContactViewController_iPhone5.h"

@protocol PetScrollerDelegate <NSObject>
- (void)showPet:(PetData *)pet;
- (void) deletePetData:(PetData *)pet;
- (void) editPetData:(PetData *)pet;
- (void) editPetData:(PetData *)pet withContactData:(ContactData *)contact;
@end

@interface PetScrollerView : UIView <UIScrollViewDelegate, PetCardDelegate, AddContactDelegate>



@property (nonatomic, retain) NSMutableArray* arrPets;
@property (nonatomic, retain) NSMutableArray* arrCards;
@property (assign) BOOL pageControlBeingUsed;
@property (assign) int numWidth;
@property (assign) int numHeight;
@property (assign) int numCurrentPage;
@property (nonatomic, retain) UIScrollView* scrollView;
@property (nonatomic, assign) id<PetScrollerDelegate> delegate;
@property (nonatomic, weak) id <AddContactDelegate> contactDelegate;


- (id) initWithArray:(NSArray *)data;
- (void) updateScroller:(PetData *)data;
- (void) updateScrollerWithDeletedPet:(PetData *)data;
- (void) createArray:(NSArray *)array;
- (void)updatePetInfo:(NSArray *)pets;
- (void)resetScroller:(NSArray *)pets;


@end
