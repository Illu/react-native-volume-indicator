
# react-native-volume-indicator

[![MIT License][license-badge]][license-url]

__WORK IN PROGRESS__ 

Replaces the default iOS volume popup by a less-obtrusive indicator.
Contains helpers to get access to your app's audio volume.

## Installation

Note: only iOS is supported at the moment.

### Mostly automatic installation

`$ react-native link react-native-volume-indicator`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` and select `Add Files to [your project's name]`
2. Go to `node_modules/react-native-volume-indicator` and add `RNVolumeIndicator.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNVolumeIndicator.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project

## Usage

Please note that you'll only be able to get the actual volume
using a physical device, as the simulator won't return a correct value.

### VolumeIndicator

_TODO_

### getVolume()

Call it whenever you need to get the volume of your app's audio.

##### Exemple
```javascript
import {getVolume} from 'react-native-volume-indicator';

class App extends React.Component {
  
  _getVolume() {
    getVolume().then(volume => {
      // ...
    })
  }
}
```


### listenToVolumeChange(callback) / stopListeningToVolumeChange()

Use `listenToVolumeChange` when you want to start listening to volume change.
Don't forget to remove the listener by calling `stopListeningToVolumeChange()`

##### Exemple
```javascript
import {listenToVolumeChange, stopListeningToVolumeChange} from 'react-native-volume-indicator';

class App extends React.Component {
  
  componentDidMount(){
    listenToVolumeChange(this._onVolumeChange);
  }
  
  componentWillUnmount(){
    stopListeningToVolumeChange();
  }
  
  _onVolumeChange(volume) {
    // ...
  }
}
```
  
## Licence ##
**MIT**

[license-badge]: http://img.shields.io/badge/license-MIT-blue.svg?style=flat
[license-url]: LICENSE