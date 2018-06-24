
import { NativeModules, NativeEventEmitter } from 'react-native';

const { RNVolumeIndicator } = NativeModules;

const volumeManagerEmitter = new NativeEventEmitter(RNVolumeIndicator);

// Subscription to volume changes
let subscription;
export const listenToVolumeChange = callback =>
  subscription = volumeManagerEmitter.addListener(
    'volumeChange',
    (volumeData) => {callback(volumeData.volume)});

export const stopListeningToVolumeChange = () => {
  subscription.remove();
};

export const getVolume = () => RNVolumeIndicator.getVolume();

export default RNVolumeIndicator;
