//
//  BSModalPickerView.m
//  CustomPicker
//
//  Created by Ben Scheirman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSModalPickerView.h"

@interface BSModalPickerView ()

@property (nonatomic) NSUInteger indexSelectedBeforeDismissal;

@end

@implementation BSModalPickerView

#pragma mark - Designated Initializer

- (id)initWithValues:(NSArray *)values {
    self = [super init];
    if (self) {
        self.values = values;
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark - Custom Getters

- (UIView *)pickerWithFrame:(CGRect)pickerFrame {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    [pickerView selectRow:self.selectedIndex inComponent:0 animated:NO];
    return pickerView;
}

- (NSString *)selectedValue {
    return [self.values objectAtIndex:self.selectedIndex];
}

#pragma mark - Custom Setters

- (void)setValues:(NSArray *)values {
    _values = values;
    
    if (_values) {
        if (self.picker) {
            UIPickerView *pickerView = (UIPickerView *)self.picker;
            [pickerView reloadAllComponents];
            self.selectedIndex = 0;
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        if (self.picker) {
            UIPickerView *pickerView = (UIPickerView *)self.picker;
            [pickerView selectRow:selectedIndex inComponent:0 animated:YES];
        }
    }
}

- (void)setSelectedValue:(NSString *)selectedValue {
    NSInteger index = [self.values indexOfObject:selectedValue];
    [self setSelectedIndex:index];
}

#pragma mark - Event Handler

- (void)onDone:(id)sender {
    self.selectedIndex = self.indexSelectedBeforeDismissal;
    [super onDone:sender];
}

#pragma mark - Picker View Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.values.count;
}

#pragma mark - Picker View Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.indexSelectedBeforeDismissal = row;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 40.0f)];
    [lbl setTextColor:[self componentColor]];
    [lbl setText:[self.values objectAtIndex:row]];
    [lbl setFont:[UIFont systemFontOfSize:18.0f]];
    [lbl setTextAlignment:NSTextAlignmentCenter];;
    return lbl;
}

-(UIColor *)componentColor{
    if (!_componentColor) {
        _componentColor = [UIColor redColor];
    }
    return _componentColor;
}
@end
