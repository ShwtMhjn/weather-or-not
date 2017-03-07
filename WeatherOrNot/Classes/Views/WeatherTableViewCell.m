//
//  WeatherTableViewCell.m
//  WeatherOrNot
//
//  Created by Sasha on 07/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//
//Custom cell for the Forecast tableview. Can be modified to show any number of properties.

#import "WeatherTableViewCell.h"
#import "WeatherCellData.h"

@implementation WeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//Set up Cell using cell data. This is generic when exposed and requires very little change if the components change in the cellData class
- (void)setUpCell:(id)cellData
{
    WeatherCellData *weatherCellData = (WeatherCellData *)cellData;
    self.date.text = weatherCellData.date;
    self.icon.image = weatherCellData.icon;
    self.temperature.text = weatherCellData.temperature;
}

@end
