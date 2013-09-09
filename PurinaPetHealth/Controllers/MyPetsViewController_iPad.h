//
//  MyPetsViewController_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/27/12.
//
//  

#import <UIKit/UIKit.h>
#import "AddAPetView_iPad.h"
#import "PetScrollerView.h"
#import "ContactListViewController.h"
#import "PetDetailsView_iPad.h"
#import "EditPetViewController.h"

@class PetDetailsView_iPad;
@class DDPageControl;

@interface MyPetsViewController_iPad : UIViewController
        <AddAPetDelegate, UIPopoverControllerDelegate,
        DatePickerDelegate, PetDetailsDelegate, PetScrollerDelegate, ModalViewControllerDelegate,
        AvatarPickerPlusDelegate, AddContactDelegate, EditPetDelegate>
{
    UIPopoverController *popover;
    UIPopoverController *contactPopover;
}

@property (nonatomic, retain) AddAPetView_iPad * addAPetView;
@property (nonatomic, retain) PetScrollerView* petScroller;

//@property (nonatomic, retain) UIPopoverController *myPopover;

@property (nonatomic, retain) UIImageView *avatar;
@property (nonatomic, retain) NSData *imageData;

@property(nonatomic, strong) id myVar;
@property(nonatomic) CGRect popoverRect;
@property(nonatomic, strong) UIPopoverController *myPopover;
@property(nonatomic, strong) DatePickerViewController *datePickerView;
@property(nonatomic, strong) NSMutableArray *contacts;
@property (nonatomic, strong) UIBarButtonItem *btnAddNew;
@property (nonatomic, retain) PetModel* petModel;

@property(nonatomic, strong) PetDetailsView_iPad *petDetails;
@property(nonatomic, strong) PetData *objCurrentPetData;
@property(nonatomic, strong) OHAttributedLabel *lblMessage;
@property(nonatomic) BOOL isFirstPetCreated;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) DDPageControl *pageControls;
@property(nonatomic, strong) NSMutableArray *arrAppointments;
@property(nonatomic, assign) BOOL isAddAPetShown;
@property(nonatomic, strong) UILabel *lblApptTitle;
@end
