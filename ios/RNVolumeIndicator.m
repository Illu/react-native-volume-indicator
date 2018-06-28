
#import "RNVolumeIndicator.h"
#import <MediaPlayer/MPVolumeView.h>
#import <UIKit/UIView.h>
#import <UIKit/UIAlertView.h>

@implementation RNVolumeIndicator
@synthesize onVolumeChangeNotification;

- (dispatch_queue_t)methodQueue
{
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    
    // Disables the default (iOS) volume pop up
    [self disableStockIndicator];
    
    [audioSession setActive:YES error:nil];
    [audioSession addObserver:self
                   forKeyPath:@"outputVolume"
                      options:0
                      context:nil];
    
    return dispatch_get_main_queue();
}

// getVolume() called from the js thread
RCT_EXPORT_METHOD(getVolume:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    CGFloat volume = audioSession.outputVolume;
    resolve(@(volume));
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"volumeChange"];
}

RCT_EXPORT_MODULE();

// Observer for volume change
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:@"outputVolume"]) {
        float volume = [self getVolume];
        [self sendEventWithName:@"volumeChange" body:@{@"volume": @(volume)}];
    }
}

-(float) getVolume{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    CGFloat volume = audioSession.outputVolume;
    return volume;
}


-(void) disableStockIndicator{
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-2000., -2000., 0.f, 0.f)];
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    volumeView.alpha = 0.1f;
    volumeView.userInteractionEnabled = NO;
    
    if (windows.count > 0) {
        [[windows objectAtIndex:0] addSubview:volumeView];
    }
}

@end

