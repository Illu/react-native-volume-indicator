
#import "RNVolumeIndicator.h"
#import <MediaPlayer/MPVolumeView.h>
#import <UIKit/UIView.h>
#import <UIKit/UIAlertView.h>

@implementation RNVolumeIndicator
@synthesize onVolumeChangeNotification;

- (dispatch_queue_t)methodQueue
{
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setActive:YES error:nil];
    [audioSession addObserver:self
                   forKeyPath:@"outputVolume"
                      options:0
                      context:nil];
    
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(getVolume:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    CGFloat volume = audioSession.outputVolume;
    resolve(@(volume));
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"volumeChange"];
}

RCT_EXPORT_MODULE();


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

@end

