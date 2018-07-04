import { NativeModules, NativeEventEmitter, View, StyleSheet, Animated } from 'react-native';
import React, {Component} from 'react';
import Indicator from './indicators';

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

// Actual Volume indicator component
export default class VolumeIndicator extends Component {

  state = {
    volume: 0,
  };

  componentDidMount() {
    getVolume().then(volume => {
      this.setState({ volume });
    });
    listenToVolumeChange(this._onVolumeChange);
  };

  componentWillUnmount() {
    stopListeningToVolumeChange();
  };

  _onVolumeChange = (volume) => {
    this.setState({ volume });
  };

  render() {
    const { style, layout } = this.props;
    const { volume } = this.state;
    return (
      <Indicator
        volume={volume}
        style={style}
        layout={layout}
      />
    );
  }
}
