#if __has_include(<React/RCTBridgeModule.h>)
  #import <React/RCTBridgeModule.h>
  #import <React/RCTEventEmitter.h>
#else
  #import "RCTBridgeModule.h"
#endif

#import <AVFoundation/AVAudioSession.h>
#import "React/RCTEventEmitter.h"
#import <MediaPlayer/MediaPlayer.h>


@interface RNVolumeIndicator : RCTEventEmitter <RCTBridgeModule>
@property (nonatomic) BOOL onVolumeChangeNotification;

-(float)getVolume;

@end
  
