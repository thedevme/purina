//
//  CreateDatePickerDataSource.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import "CreateSingleItemDataSource.h"
#import <IBAForms/IBAForms.h>
#import "Constants.h"
#import "MedicalData.h"

@implementation CreateSingleItemDataSource


- (id) initWithModel:(id)aModel
{
    if ((self = [super initWithModel:aModel]))
    {
        IBAFormFieldStyle *style = [[IBAFormFieldStyle alloc] init];
        style.labelTextColor = [UIColor darkGrayColor];
        style.labelFont = [UIFont fontWithName:kHelveticaNeueCondBold size:12.0f];
        style.labelTextAlignment = UITextAlignmentLeft;
        self.objMedicalData = [[MedicalData alloc] init];
        
        //style.valueFrame = CGRectMake(IBAFormFieldValueX, IBAFormFieldValueY, IBAFormFieldValueWidth + 100, IBAFormFieldValueHeight);
        
        style.valueTextColor = [UIColor darkGrayColor];
        style.valueBackgroundColor = [UIColor clearColor];
        style.labelFrame = CGRectMake(IBAFormFieldLabelX, IBAFormFieldLabelY, IBAFormFieldLabelWidth + 100, IBAFormFieldLabelHeight);
        style.labelBackgroundColor = [UIColor clearColor];
        style.activeColor = [UIColor clearColor];
        style.valueTextAlignment = UITextAlignmentRight;
        [self createApptTitle:style];
    }
    
    return self;
}

- (void) createApptTitle:(IBAFormFieldStyle *)style
{
    IBAFormSection *titleSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    titleSection.formFieldStyle = style;
    
    titleSection.headerView.backgroundColor = [UIColor redColor];
    [titleSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"name" title:@"Name"]];
}






- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath
{
    [super setModelValue:value forKeyPath:keyPath];
    
    self.objMedicalData.name = [self.model valueForKeyPath:@"name"];
    
    [self.delegate saveMedialData:self.objMedicalData];
}

@end
