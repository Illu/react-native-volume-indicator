
#import "RNVolumeIndicator.h"
#import <MediaPlayer/MPVolumeView.h>
#import <UIKit/UIView.h>
#import <UIKit/UIAlertView.h>


@implementation RNVolumeIndicator
@synthesize onVolumeChangeNotification;

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
    
    
    // enables volume listener
    //    [[NSNotificationCenter defaultCenter]
    //     addObserver:self
    //     selector:@selector(volumeChanged:)
    //     name:@"AVSystemController_SystemVolumeDidChangeNotification"
    //     object:nil];
    //
    //    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    
    return dispatch_get_main_queue();
}


RCT_EXPORT_MODULE()


- (NSArray<NSString *> *)supportedEvents {
    return @[@"onVolumeChange"];
}


RCT_EXPORT_METHOD(getVolume:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    CGFloat volume = audioSession.outputVolume;
    resolve(@(volume));
    
    // Old
    //    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    //    resolve(@(musicPlayer.volume));
}

@end

