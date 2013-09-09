//
//  CreateDatePickerDataSource.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import "CreateDatePickerDataSource.h"
#import <IBAForms/IBAForms.h>
#import "Constants.h"
#import "MedicalData.h" 

@implementation CreateDatePickerDataSource


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
        [self createAppointmentDate:style];
    }

    return self;
}

- (void) createApptTitle:(IBAFormFieldStyle *)style
{
    IBAFormSection *titleSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    titleSection.formFieldStyle = style;

    titleSection.headerView.backgroundColor = [UIColor redColor];
    [titleSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"name" title:@"Name"]];
    //[textField becomeFirstResponder];
}

- (void) createAppointmentDate:(IBAFormFieldStyle *)style
{
    IBAFormSection *dateFieldSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    dateFieldSection.formFieldStyle = style;
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];

    [dateTimeFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateTimeFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateTimeFormatter setDateFormat:@"MMMM dd yyyy"];

    [dateFieldSection addFormField:[[IBADateFormField alloc] initWithKeyPath:@"date"
                                                                       title:@"Date"
                                                                defaultValue:[NSDate date]
                                                                        type:IBADateFormFieldTypeDate
                                                               dateFormatter:dateTimeFormatter]];
}





- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath
{
    [super setModelValue:value forKeyPath:keyPath];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];

    NSString *stringFromDate = [formatter stringFromDate:[self.model valueForKeyPath:@"date"]];

    //NSLog(@"class: %@", stringFromDate);
    self.objMedicalData.name = [self.model valueForKeyPath:@"name"];
    self.objMedicalData.date = stringFromDate;

    [self.delegate saveMedialData:self.objMedicalData];
}

@end
