
#import "RNVolumeIndicator.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <MediaPlayer/MPVolumeView.h>
#import <UIKit/UIView.h>
#import <UIKit/UIAlertView.h>


@implementation RNVolumeIndicator

- (dispatch_queue_t)methodQueue
{
    // Hides default iOS volume slider
    //    CGRect frame = CGRectMake(-1000, -1000, 100, 100);
    //    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:frame];
    //    [volumeView sizeToFit];
    //    [self.view addSubview:volumeView];
    
    // Disables the default iOS volume slider
    //    [super viewDidLoad];
    //    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame: CGRectZero];
    //    [self.view addSubview: volumeView];
    //    [volumeView release];
    
    return dispatch_get_main_queue();
}


RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(isAvailable:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    //    UIView *myBox  = [[UIView alloc] initWithFrame:CGRectMake(180, 35, 10, 10)];
    //    myBox.backgroundColor = [UIColor lightGrayColor];
    //    [self.view addSubview:myBox];
    
    LAContext *context = [[LAContext alloc] init];
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL]) {
        resolve(@(YES));
    } else {
        resolve(@(NO));
    }
}

@end

