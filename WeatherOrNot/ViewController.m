//
//  ViewController.m
//  WeatherOrNot
//
//  Created by Sasha on 06/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

#import "ViewController.h"
#import "WeatherStore.h"
#import "WeatherOrNot-Swift.h"
#import "Utilities.h"
#import "WeatherTableViewCell.h"
#import "WeatherCellData.h"

@interface ViewController ()
{
    BOOL isFahrenheit;
    NSArray *forecastArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _forcastTable.delegate = self;
    _forcastTable.dataSource = self;
    //Update location so the App fetches data based on location. THis does not work very well on the simulator, but the coordinates are still on Earth :) We can manage
    
//    ViewController *viewController = [[ViewController alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    CLLocation *location = [self.locationManager location];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self fetchWeatherData:location];
}

- (void)fetchWeatherData:(CLLocation *)location{
    [[WeatherStore sharedInstance] fetchWeatherDataForLocation:location onSuccess:^(id weatherData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self populateUI:weatherData];
        });

    } onFailure:^(NSError *error) {
        //Handle error
    }];
}

- (void) populateUI:(id)weatherData {
    Weather *weather = (Weather *)weatherData;
    Forecast *firstObject = [[weather forecast] firstObject];
   NSString *temperature = [NSString stringWithFormat:@"%.2fº", [firstObject.temp floatValue]];
    [_temperatureButton setTitle:[NSString stringWithFormat:@"%@", temperature] forState:UIControlStateSelected]; //Convert to Celcius
    [_temperatureButton setTitle:[NSString stringWithFormat:@"%@", temperature] forState:UIControlStateNormal]; //Convert to Celcius

    _cityLabel.text             = [NSString stringWithFormat:@"%@", weather.city.name];
    _weatherConditionLabel.text = [NSString stringWithFormat:@"%@", firstObject.weatherDescription];
    _iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", firstObject.icon]];
    [self forecastArrayForTableView:weather.forecast];
}

- (IBAction)changeButtonDisplay:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = isFahrenheit;
    double temperature = button.currentTitle.doubleValue;

    if (isFahrenheit == YES) {
        [button setTitle:[NSString stringWithFormat:@"%.2fº", [[Utilities temperatureToCelcius:temperature] floatValue]] forState:UIControlStateNormal]; //Convert to Celcius
        [button setTitle:[NSString stringWithFormat:@"%.2fº", [[Utilities temperatureToCelcius:temperature] floatValue]] forState:UIControlStateSelected]; //Convert to Celcius
    }
    else {
        [button setTitle:[NSString stringWithFormat:@"%.2fº", [[Utilities temperatureToFahrenheit:temperature] floatValue]] forState:UIControlStateNormal]; //Convert to Fahrenheit
        [button setTitle:[NSString stringWithFormat:@"%.2fº", [[Utilities temperatureToFahrenheit:temperature] floatValue]] forState:UIControlStateSelected]; //Convert to Fahrenheit
 }
    isFahrenheit = !isFahrenheit;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertController *errorAlert = [[UIAlertController alloc] initWithNibName:@"AlertView" bundle:[NSBundle mainBundle]];
    [self presentViewController:errorAlert animated:YES completion:^{
        [errorAlert removeFromParentViewController];
    }];
}

#pragma mark -- Make the forecast Array --
- (void) forecastArrayForTableView:(NSArray *)array {
    NSMutableArray *forecastList = [[NSMutableArray alloc] initWithArray:array copyItems:NO];
    [forecastList removeObjectAtIndex:0];
    NSMutableArray *cellDataArray = [[NSMutableArray alloc] init];
    for (Forecast *forecast in forecastList)
    {
        WeatherCellData *cellData = [[WeatherCellData alloc] initWithForecast:forecast];
        [cellDataArray addObject:cellData];
    }
    forecastArray = cellDataArray;
    [_forcastTable reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return forecastArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 60.0f;
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableViewCellIdentifier = @"WeatherCell";
    static NSString *NibName = @"WeatherTableViewCell";
    
    //Register nib
    UINib *cellNib = [UINib nibWithNibName:NibName bundle:nil];
    [self.forcastTable registerNib:cellNib forCellReuseIdentifier:TableViewCellIdentifier];
    
    //Reuse cell
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];

    if (cell == nil){
        //initialize the cell view from the xib file
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NibName
                                                      owner:self options:nil];
        cell = (WeatherTableViewCell *)[nibs objectAtIndex:0];
    }
    
    // Configure the cell...
    WeatherCellData *cellData = [forecastArray objectAtIndex:indexPath.row];
    [cell setUpCell:cellData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
